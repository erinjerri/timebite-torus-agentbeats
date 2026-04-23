import Foundation

struct AgentBeatsSeed {
    var scenario: AgentTaskScenario
    var actions: [ActionItem]
    var habits: [HabitEntry]
    var goals: [GoalItem]
    var dailyLog: DailyLog
    var actionLog: [AgentActionLog]
    var selectedActionId: UUID?
}

enum AgentBeatsMockData {
    static func makeSeed() -> AgentBeatsSeed {
        let now = Date()
        let calendar = Calendar.current

        let primaryAction = ActionItem(
            title: "Ship the Action tab",
            context: "Primary hackathon loop: start, stop, and complete a measurable task.",
            estimateMinutes: 25,
            state: .ready,
            isPinned: true,
            order: 0
        )
        let reviewAction = ActionItem(
            title: "Review scenario logs",
            context: "Verify the agent-readable event trail is complete.",
            estimateMinutes: 15,
            state: .stopped,
            accumulatedSeconds: 420,
            startedAt: nil,
            stoppedAt: calendar.date(byAdding: .minute, value: -18, to: now),
            isPinned: false,
            order: 1
        )
        let publishAction = ActionItem(
            title: "Publish hackathon pitch",
            context: "Keep the submission narrative tight and visible.",
            estimateMinutes: 30,
            state: .completed,
            accumulatedSeconds: 1_260,
            startedAt: nil,
            stoppedAt: calendar.date(byAdding: .minute, value: -95, to: now),
            completedAt: calendar.date(byAdding: .minute, value: -78, to: now),
            isPinned: false,
            order: 2
        )
        let syncAction = ActionItem(
            title: "Sync goals with benchmark",
            context: "Tie the UI state back to the evaluation rubric.",
            estimateMinutes: 20,
            state: .ready,
            isPinned: false,
            order: 3
        )

        let startReview = AgentActionLog(
            actionId: reviewAction.id,
            actionTitle: reviewAction.title,
            eventKind: .started,
            fromStateRaw: ActionState.ready.rawValue,
            toStateRaw: ActionState.running.rawValue,
            timestamp: calendar.date(byAdding: .minute, value: -32, to: now) ?? now,
            note: "Initial benchmark capture."
        )
        let stopReview = AgentActionLog(
            actionId: reviewAction.id,
            actionTitle: reviewAction.title,
            eventKind: .stopped,
            fromStateRaw: ActionState.running.rawValue,
            toStateRaw: ActionState.stopped.rawValue,
            timestamp: calendar.date(byAdding: .minute, value: -18, to: now) ?? now,
            note: "Paused after verification."
        )
        let startPublish = AgentActionLog(
            actionId: publishAction.id,
            actionTitle: publishAction.title,
            eventKind: .started,
            fromStateRaw: ActionState.ready.rawValue,
            toStateRaw: ActionState.running.rawValue,
            timestamp: calendar.date(byAdding: .minute, value: -100, to: now) ?? now,
            note: "Demo draft in motion."
        )
        let completePublish = AgentActionLog(
            actionId: publishAction.id,
            actionTitle: publishAction.title,
            eventKind: .completed,
            fromStateRaw: ActionState.running.rawValue,
            toStateRaw: ActionState.completed.rawValue,
            timestamp: calendar.date(byAdding: .minute, value: -78, to: now) ?? now,
            note: "Submission-ready."
        )

        return AgentBeatsSeed(
            scenario: AgentTaskScenario(
                title: "AgentBeats Hackathon Run",
                mission: "Prove that an agent can choose an action, move it through visible state changes, and leave a measurable trace.",
                targetActionTitle: primaryAction.title,
                environmentPrinciple: "No backend, no auth, no hidden state. Every important action should be visible and logged locally.",
                successCriteria: [
                    "Start the target action",
                    "Stop or complete the target action",
                    "Record the transition in the action log",
                    "Keep the four-tab environment readable on iOS simulator",
                ],
                demoScript: [
                    "Open Action and tap the target action.",
                    "Press Start, wait a beat, then press Stop.",
                    "Press Start again and finish with Complete.",
                    "Switch to Dash and point at the updated score and log trail.",
                ],
                scoringNotes: "The benchmark favors visible state transitions, a stable log history, and a clean end state."
            ),
            actions: [primaryAction, reviewAction, publishAction, syncAction],
            habits: [
                HabitEntry(
                    title: "Log every transition",
                    cadence: .daily,
                    streakDays: 7,
                    targetCount: 3,
                    completedCount: 2,
                    lastCompletedAt: calendar.date(byAdding: .hour, value: -2, to: now),
                    note: "The environment should make execution auditable.",
                    isPinned: true
                ),
                HabitEntry(
                    title: "Keep one active action",
                    cadence: .daily,
                    streakDays: 5,
                    targetCount: 1,
                    completedCount: 1,
                    lastCompletedAt: calendar.date(byAdding: .hour, value: -1, to: now),
                    note: "Single-thread focus keeps evaluation easier.",
                    isPinned: false
                ),
                HabitEntry(
                    title: "Write the demo note",
                    cadence: .weekly,
                    streakDays: 2,
                    targetCount: 1,
                    completedCount: 1,
                    lastCompletedAt: calendar.date(byAdding: .day, value: -1, to: now),
                    note: "Keeps the submission story aligned.",
                    isPinned: false
                ),
            ],
            goals: [
                GoalItem(
                    title: "Action loop proven",
                    detail: "The primary action should move through start, stop, and complete with logs attached.",
                    targetValue: 3,
                    achievedValue: 2,
                    dueDate: calendar.date(byAdding: .day, value: 1, to: now) ?? now,
                    state: .active,
                    linkedActionTitle: primaryAction.title,
                    emphasis: 0
                ),
                GoalItem(
                    title: "Track view shows live signal",
                    detail: "Habits and today's log should make state transitions legible.",
                    targetValue: 4,
                    achievedValue: 3,
                    dueDate: calendar.date(byAdding: .day, value: 2, to: now) ?? now,
                    state: .active,
                    linkedActionTitle: reviewAction.title,
                    emphasis: 1
                ),
                GoalItem(
                    title: "Hackathon pitch ready",
                    detail: "The benchmark narrative should be easy to demo in under a minute.",
                    targetValue: 5,
                    achievedValue: 4,
                    dueDate: calendar.date(byAdding: .day, value: 3, to: now) ?? now,
                    state: .atRisk,
                    linkedActionTitle: publishAction.title,
                    emphasis: 2
                ),
            ],
            dailyLog: DailyLog(
                focusMinutesTarget: 120,
                focusMinutesCompleted: 0,
                actionsStarted: 0,
                actionsStopped: 0,
                actionsCompleted: 0,
                transitionsRecorded: 0,
                summary: "Local mock environment loaded."
            ),
            actionLog: [completePublish, startPublish, stopReview, startReview],
            selectedActionId: primaryAction.id
        )
    }
}
