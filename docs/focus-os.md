# Focus OS — Rings + Torus Visual Language

This doc standardizes terminology for TimeBite’s “ring timer” UI across Apple platforms.

## Correct Apple naming (what to call the thing)

### 2D (iOS / watchOS / macOS)
- **Apple’s recognizable pattern name:** **Activity rings** (from Apple Fitness: Move / Exercise / Stand).
- **Generic UI name (platform-agnostic):** **circular progress indicator** / **progress ring**.

Important: Apple does **not** ship a single, public “ActivityRing” UI component you drop into SwiftUI. In practice, teams implement a **progress ring** using `Circle().trim(...)`, `ProgressView` (circular), or `Gauge` (circular styles), then apply “activity ring” styling.

### 3D (visionOS / spatial computing)
- **Correct geometry name:** **torus** (a donut-shaped ring).
- **UI name in product language:** **3D torus timer** / **spatial torus progress ring**.

## Product intent
TimeBite uses rings for one job: make “remaining time” and “momentum” instantly legible.

- **2D ring** = fast, familiar, reliable (fits iOS/watchOS/macOS).
- **3D torus** = spatial “wow” + presence (fits visionOS).

## Platform mapping (what we ship where)

### iOS
- Primary visualization: **2D Activity Rings-style progress ring**
- Secondary: ring segments (optional) per category/intent lane

### watchOS
- Primary visualization: **2D progress ring** optimized for glanceability

### macOS
- Primary visualization: **2D progress ring** in a dashboard card

### visionOS
- Primary visualization: **3D torus progress object**
- Optional: 2D ring panels as supporting UI

## Spec language (copy/paste)

When writing requirements/specs, use this phrasing:
- “**2D Activity Rings-style progress ring (circular progress indicator)** on iOS/watchOS/macOS”
- “**3D torus progress ring** on visionOS”

Avoid ambiguous wording like “Apple ring component” in specs—use the terms above.

## Implementation notes (demo-first)

### 2D ring (SwiftUI)
Common implementation approaches:
- `Circle().trim(from: 0, to: progress)` + `StrokeStyle(lineWidth:..., lineCap: .round)`
- `ProgressView(value:progress).progressViewStyle(.circular)` (less “activity-ring” looking)
- `Gauge(value:progress).gaugeStyle(.accessoryCircular)` (good for watch-like widgets)

### 3D torus (visionOS)
Demo-friendly approach:
- RealityKit: render a torus mesh and animate a material/texture mask or segment geometry to represent progress.
- If time-constrained: fake depth with layered 2D rings in a 3D container, then upgrade to true torus geometry later.

## Source inspiration (design reference)
- Fivecube dashboard inspiration includes a **timer-style progress ring** that visually matches the Apple Watch/Fitness “ring” language.
- The “TimeBite — UI Concepts.html” file uses the phrase “reverse activity ring” and “depleting ring” for this pattern.

