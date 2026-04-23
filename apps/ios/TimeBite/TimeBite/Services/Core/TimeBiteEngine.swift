//
//  TimeBiteEngine.swift
//  TimeBite
//
//  Created by Erin Jerri on 3/27/26.
//

import Foundation

@MainActor
final class TimeBiteEngine {
    var onUpdate: (() -> Void)?

    private var timer: Timer?
    private weak var boundTask: TaskItem?

    func bind(to task: TaskItem?) {
        boundTask = task
        resumeActiveTaskIfNeeded()
    }

    func start(task: TaskItem) {
        if let activeTask = boundTask, activeTask.id != task.id {
            stop(task: activeTask)
        }

        let now = Date()
        boundTask = task
        task.status = .running
        task.isActive = true
        task.startedAt = task.startedAt ?? now
        task.endedAt = nil
        task.lastTickAt = now

        startTimer()
        onUpdate?()
    }

    func stop(task: TaskItem) {
        guard task.isRunning else {
            timer?.invalidate()
            timer = nil
            return
        }

        let now = Date()
        update(task: task, at: now)
        finalize(task: task, at: now, completed: task.remainingSeconds == 0)
    }

    private func resumeActiveTaskIfNeeded() {
        guard let boundTask, boundTask.isRunning else {
            timer?.invalidate()
            timer = nil
            return
        }

        let now = Date()
        update(task: boundTask, at: now)

        if boundTask.isRunning {
            boundTask.lastTickAt = now
            startTimer()
        } else {
            timer?.invalidate()
            timer = nil
        }

        onUpdate?()
    }

    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self else { return }
            Task { @MainActor in
                self.tick()
            }
        }
    }

    private func tick() {
        guard let boundTask, boundTask.isRunning else {
            timer?.invalidate()
            timer = nil
            return
        }

        update(task: boundTask, at: Date())

        if !boundTask.isRunning {
            timer?.invalidate()
            timer = nil
        }

        onUpdate?()
    }

    private func update(task: TaskItem, at now: Date) {
        guard task.isRunning, let lastTickAt = task.lastTickAt else { return }

        let elapsed = max(Int(now.timeIntervalSince(lastTickAt).rounded(.down)), 0)
        guard elapsed > 0 else { return }

        let consumed = min(elapsed, task.remainingSeconds)
        task.remainingSeconds -= consumed
        task.spentSeconds += consumed
        task.lastTickAt = now

        if task.remainingSeconds == 0 {
            finalize(task: task, at: now, completed: true)
        }
    }

    private func finalize(task: TaskItem, at now: Date, completed: Bool) {
        task.status = completed ? .completed : .paused
        task.isActive = false
        task.lastTickAt = nil
        task.endedAt = now

        timer?.invalidate()
        timer = nil

        onUpdate?()
    }
}
