import Combine
import Foundation

@MainActor
final class AgentBeatsEnvironment: ObservableObject {
    @Published var scenario: AgentTaskScenario
    @Published var actions: [ActionItem]
    @Published var habits: [HabitEntry]
    @Published var goals: [GoalItem]
    @Published var dailyLog: DailyLog
    @Published var actionLog: [AgentActionLog]
    @Published var selectedActionId: UUID?

    init(seed: AgentBeatsSeed? = nil) {
        let seed = seed ?? AgentBeatsMockData.makeSeed()
        scenario = seed.scenario
        actions = seed.actions
        habits = seed.habits
        goals = seed.goals
        dailyLog = seed.dailyLog
        actionLog = seed.actionLog.sorted(by: { $0.timestamp > $1.timestamp })
        selectedActionId = seed.selectedActionId ?? seed.actions.first?.id
        syncDailyLog()
    }

    var selectedAction: ActionItem? {
        guard let selectedActionId else { return actions.first }
        return actions.first(where: { $0.id == selectedActionId }) ?? actions.first
    }

    var activeAction: ActionItem? {
        actions.first(where: { $0.state == .running })
    }

    var completedActions: Int {
        actions.filter { $0.state == .completed }.count
    }

    var readyActions: Int {
        actions.filter { $0.state == .ready }.count
    }

    var transitionCount: Int {
        actionLog.count
    }

    var benchmarkScore: Int {
        scenario.score(actions: actions, logs: actionLog, dailyLog: dailyLog)
    }

    func select(_ action: ActionItem) {
        selectedActionId = action.id
    }

    func startSelectedAction() {
        guard let selectedAction else { return }
        start(actionId: selectedAction.id)
    }

    func stopSelectedAction() {
        guard let selectedAction else { return }
        stop(actionId: selectedAction.id)
    }

    func completeSelectedAction() {
        guard let selectedAction else { return }
        complete(actionId: selectedAction.id)
    }

    func start(actionId: UUID) {
        guard let index = actions.firstIndex(where: { $0.id == actionId }) else { return }
        guard actions[index].state != .completed else { return }

        if let activeIndex = actions.firstIndex(where: { $0.state == .running }), activeIndex != index {
            stop(actionId: actions[activeIndex].id, note: "Auto-stopped before focus switch")
        }

        let now = Date()
        let previousState = actions[index].state
        actions[index].state = .running
        actions[index].startedAt = now
        actions[index].stoppedAt = nil
        actions[index].completedAt = nil
        actions[index].updatedAt = now
        selectedActionId = actionId
        recordLog(
            action: actions[index],
            eventKind: .started,
            fromState: previousState,
            toState: .running,
            at: now,
            note: actions[index].context
        )
        syncDailyLog()
    }

    func stop(actionId: UUID, note: String? = nil) {
        guard let index = actions.firstIndex(where: { $0.id == actionId }) else { return }
        guard actions[index].state == .running else { return }

        let now = Date()
        let previousState = actions[index].state
        actions[index].accumulatedSeconds = actions[index].activeRuntimeSeconds(at: now)
        actions[index].startedAt = nil
        actions[index].state = .stopped
        actions[index].stoppedAt = now
        actions[index].updatedAt = now
        recordLog(
            action: actions[index],
            eventKind: .stopped,
            fromState: previousState,
            toState: .stopped,
            at: now,
            note: note
        )
        syncDailyLog()
    }

    func complete(actionId: UUID, note: String? = nil) {
        guard let index = actions.firstIndex(where: { $0.id == actionId }) else { return }
        guard actions[index].state != .completed else { return }

        let now = Date()
        let previousState = actions[index].state
        if previousState == .running {
            actions[index].accumulatedSeconds = actions[index].activeRuntimeSeconds(at: now)
            actions[index].startedAt = nil
            actions[index].stoppedAt = now
        }

        actions[index].state = .completed
        actions[index].completedAt = now
        actions[index].updatedAt = now
        recordLog(
            action: actions[index],
            eventKind: .completed,
            fromState: previousState,
            toState: .completed,
            at: now,
            note: note
        )
        syncDailyLog()
    }

    func resetEnvironment() {
        let seed = AgentBeatsMockData.makeSeed()
        scenario = seed.scenario
        actions = seed.actions
        habits = seed.habits
        goals = seed.goals
        dailyLog = seed.dailyLog
        actionLog = seed.actionLog.sorted(by: { $0.timestamp > $1.timestamp })
        selectedActionId = seed.selectedActionId ?? seed.actions.first?.id
        syncDailyLog()
    }

    func recentLogs(limit: Int = 6) -> [AgentActionLog] {
        Array(actionLog.prefix(limit))
    }

    private func recordLog(
        action: ActionItem,
        eventKind: AgentActionEventKind,
        fromState: ActionState,
        toState: ActionState,
        at timestamp: Date,
        note: String?
    ) {
        actionLog.insert(
            AgentActionLog(
                actionId: action.id,
                actionTitle: action.title,
                eventKind: eventKind,
                fromStateRaw: fromState.rawValue,
                toStateRaw: toState.rawValue,
                timestamp: timestamp,
                note: note
            ),
            at: 0
        )
    }

    private func syncDailyLog() {
        let now = Date()
        let started = actionLog.filter { $0.eventKind == .started }.count
        let stopped = actionLog.filter { $0.eventKind == .stopped }.count
        let completed = actionLog.filter { $0.eventKind == .completed }.count
        let transitions = actionLog.count
        let focusMinutes = actions.reduce(0) { partialResult, action in
            partialResult + action.activeRuntimeSeconds(at: now) / 60
        }
        let activeName = activeAction?.title ?? "no active action"

        dailyLog = DailyLog(
            id: DailyLog.dayKey(for: now),
            date: now,
            focusMinutesTarget: dailyLog.focusMinutesTarget,
            focusMinutesCompleted: focusMinutes,
            actionsStarted: started,
            actionsStopped: stopped,
            actionsCompleted: completed,
            transitionsRecorded: transitions,
            lastEventAt: actionLog.first?.timestamp,
            summary: "Environment live. Active: \(activeName). \(completed) completion(s), \(started) start(s), \(stopped) stop(s)."
        )
    }
}
