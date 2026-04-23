//
//  AppState.swift
//  TimeBite
//
//  Created by Erin Jerri on 3/27/26.
//

import Combine
import Foundation

@MainActor
final class AppState: ObservableObject {
    @Published private(set) var allTasks: [TaskItem] = []
    @Published private(set) var tasks: [TaskItem] = []
    @Published var dailyIntent: String
    @Published var projects: [DemoProject]
    @Published var selectedProjectId: UUID
    @Published private(set) var aiReallocationSuggestion: AiReallocationSuggestion?

    let store: TaskStore
    let engine: TimeBiteEngine
    private let demoStore: DemoFocusStore

    private var lastAttributedTaskId: UUID?
    private var lastAttributedSpentSeconds: Int = 0
    private var didApplyAiReallocation: Bool = false

    convenience init() {
        self.init(store: TaskStore())
    }

    init(store: TaskStore) {
        self.store = store
        self.demoStore = DemoFocusStore()
        let loadedTasks = store.load()
        self.allTasks = loadedTasks
        self.tasks = loadedTasks.filter { $0.dayKey == DayKeyFormatter.key(for: .now) }
        self.engine = TimeBiteEngine()
        let demoState = demoStore.load()
        self.dailyIntent = demoState.dailyIntent
        self.projects = demoState.projects
        self.selectedProjectId = demoState.projects.first?.id ?? UUID()
        self.engine.onUpdate = { [weak self] in
            self?.save()
        }
        self.engine.bind(to: activeTask)
        refreshAiSuggestionIfNeeded()
    }

    var activeTask: TaskItem? {
        tasks.first(where: { $0.isRunning })
    }

    func reloadTodayTasks() {
        allTasks = store.load()
        tasks = allTasks.filter { $0.dayKey == DayKeyFormatter.key(for: .now) }
        engine.bind(to: activeTask)
    }

    func createTask(
        title: String,
        category: TaskCategory,
        durationMinutes: Int,
        captureSource: TaskCaptureSource = .typed
    ) {
        let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        let task = TaskItem(
            dayKey: DayKeyFormatter.key(for: .now),
            title: trimmed,
            category: category,
            durationMinutes: durationMinutes,
            captureSource: captureSource
        )

        tasks.insert(task, at: 0)
        allTasks.insert(task, at: 0)
        save()
        engine.bind(to: activeTask)
    }

    func start(_ task: TaskItem) {
        engine.start(task: task)
        save()
    }

    func stopActiveTask() {
        guard let activeTask else { return }
        engine.stop(task: activeTask)
        save()
    }

    func suggestedCategory(for title: String) -> TaskCategory {
        TaskCategorizer.suggestedCategory(for: title)
    }

    func seedDemoTasks() {
        createTask(title: "Buy groceries", category: .admin, durationMinutes: 30)
        createTask(title: "Code portfolio", category: .work, durationMinutes: 60)
        createTask(title: "Run for 20 mins", category: .fitness, durationMinutes: 20)
    }

    func resetDemoScenario() {
        let fresh = DemoFocusState.default()
        dailyIntent = fresh.dailyIntent
        projects = fresh.projects
        selectedProjectId = fresh.projects.first?.id ?? selectedProjectId
        aiReallocationSuggestion = nil
        didApplyAiReallocation = false
        lastAttributedTaskId = nil
        lastAttributedSpentSeconds = 0
        saveDemoState()
        refreshAiSuggestionIfNeeded()
    }

    var completionScore: Int {
        guard !projects.isEmpty else { return 0 }
        let average = projects.map(\.progressToCap).reduce(0, +) / Double(projects.count)
        return Int((average * 100).rounded())
    }

    var reflectionScore: Int {
        guard !projects.isEmpty else { return 0 }
        let values = projects.map { $0.reflectionResult?.scoreValue ?? 0.0 }
        let average = values.reduce(0, +) / Double(values.count)
        return Int((average * 100).rounded())
    }

    func refreshAiSuggestionIfNeeded() {
        aiReallocationSuggestion = didApplyAiReallocation ? nil : buildAiReallocationSuggestion()
    }

    func applyAiReallocation() {
        guard let suggestion = aiReallocationSuggestion else { return }
        guard let fromIndex = projects.firstIndex(where: { $0.id == suggestion.fromProjectId }),
              let toIndex = projects.firstIndex(where: { $0.id == suggestion.toProjectId }) else { return }

        let deltaSeconds = suggestion.seconds
        guard projects[fromIndex].weeklyCapSeconds >= deltaSeconds else { return }

        projects[fromIndex].weeklyCapSeconds -= deltaSeconds
        projects[toIndex].weeklyCapSeconds += deltaSeconds
        didApplyAiReallocation = true
        saveDemoState()
        refreshAiSuggestionIfNeeded()
    }

    func resetTodayPlan() {
        let todayKey = DayKeyFormatter.key(for: .now)
        tasks.removeAll()
        allTasks.removeAll { $0.dayKey == todayKey }
        save()
    }

    func completeReflection(
        appResult _: ReflectionResult,
        incomeResult _: ReflectionResult,
        brandResult _: ReflectionResult?,
        note _: String
    ) {
        // Reflection is handled locally in later passes; keep the compatibility hook for now.
    }

    private func save() {
        attributeActiveTaskTimeToSelectedProject()
        store.save(tasks: allTasks)
        saveDemoState()
        objectWillChange.send()
    }

    func saveDemoState() {
        demoStore.save(
            DemoFocusState(
                dailyIntent: dailyIntent,
                projects: projects,
                updatedAt: .now
            )
        )
    }

    private func attributeActiveTaskTimeToSelectedProject() {
        guard let activeTask else {
            lastAttributedTaskId = nil
            lastAttributedSpentSeconds = 0
            return
        }

        if lastAttributedTaskId != activeTask.id {
            lastAttributedTaskId = activeTask.id
            lastAttributedSpentSeconds = activeTask.spentSeconds
            return
        }

        let delta = activeTask.spentSeconds - lastAttributedSpentSeconds
        guard delta > 0 else { return }
        lastAttributedSpentSeconds = activeTask.spentSeconds

        guard let index = projects.firstIndex(where: { $0.id == selectedProjectId }) else { return }
        projects[index].spentSeconds += delta
        refreshAiSuggestionIfNeeded()
    }

    private func buildAiReallocationSuggestion() -> AiReallocationSuggestion? {
        guard projects.count >= 2 else { return nil }

        guard let hackathon = projects.first(where: { $0.name.localizedCaseInsensitiveContains("hackathon") })
            ?? projects.sorted(by: { $0.priority < $1.priority }).first else { return nil }

        let sortedByPriority = projects.sorted(by: { $0.priority < $1.priority })
        guard let donor = sortedByPriority.last(where: { $0.id != hackathon.id && $0.weeklyCapSeconds >= 2 * 3_600 }) else {
            return nil
        }

        let hackathonProgress = hackathon.progressToCap
        let donorProgress = donor.progressToCap

        let shouldReallocate = hackathonProgress + 0.10 < donorProgress
        guard shouldReallocate else { return nil }

        let hours = 2
        return AiReallocationSuggestion(
            fromProjectId: donor.id,
            toProjectId: hackathon.id,
            seconds: hours * 3_600,
            fromProjectName: donor.name,
            toProjectName: hackathon.name,
            reason: "Hackathon is behind plan relative to the other projects. Move time from a lower-priority project to catch up."
        )
    }
}

enum DayKeyFormatter {
    static func key(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = .current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}

struct AiReallocationSuggestion: Identifiable, Equatable {
    var id: String { "\(fromProjectId.uuidString)->\(toProjectId.uuidString):\(seconds)" }
    let fromProjectId: UUID
    let toProjectId: UUID
    let seconds: Int
    let fromProjectName: String
    let toProjectName: String
    let reason: String

    var hours: Int { max(seconds / 3_600, 0) }

    var summary: String {
        "Hackathon is behind plan. Reallocate \(hours)h from \(fromProjectName) → \(toProjectName)."
    }
}
