# SwiftwithSwiftUI

A living reference project for SwiftUI learnings, new Apple feature implementations, and real-world performance best practices.

---

## 📋 Tracking Changes

Every meaningful change is logged in [CHANGELOG.md](CHANGELOG.md) following the [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) convention.  
Automated CI runs on every push and pull request — see [`.github/workflows/ci.yml`](.github/workflows/ci.yml).

---

## ⚡ SwiftUI Performance Best Practices

The annotated examples live in [`SwiftUIPerformanceTips.swift`](SwiftUIPerformanceTips.swift).  
Below is a quick-reference summary of the most impactful patterns.

### 1. Prefer `let` over `var` in view models
Use value-type constants wherever possible to reduce unnecessary state invalidation.

### 2. Use `equatable` conformance to skip redraws
Conform view models to `Equatable` (or use `.equatable()` modifier) so SwiftUI can diff them cheaply and avoid body re-evaluations.

```swift
struct UserRow: View, Equatable {
    let user: User
    var body: some View { Text(user.name) }
}
```

### 3. Split large views into smaller subviews
Smaller views have smaller `body` scopes, so SwiftUI only re-renders the subtree that actually changed.

```swift
// ❌ One monolithic view
struct DashboardView: View {
    @State private var count = 0
    var body: some View {
        VStack {
            // hundreds of lines — ALL re-evaluated on any state change
        }
    }
}

// ✅ Decomposed into focused subviews
struct DashboardView: View {
    @State private var count = 0
    var body: some View {
        VStack {
            HeaderView()          // only re-renders when its own state changes
            CounterView(count: count)
            FooterView()
        }
    }
}
```

### 4. Use `@StateObject` for owned objects, `@ObservedObject` for injected ones
Mixing these up causes objects to be recreated on every parent re-render.

```swift
// ✅ Owned by this view — stable lifetime
@StateObject private var viewModel = MyViewModel()

// ✅ Injected from outside — not owned here
@ObservedObject var settings: AppSettings
```

### 5. Lazy stacks for long lists
`LazyVStack` / `LazyHStack` / `List` only render visible rows, keeping memory and CPU usage flat.

```swift
ScrollView {
    LazyVStack {
        ForEach(items) { item in
            ItemRow(item: item)
        }
    }
}
```

### 6. Avoid heavy work in `body`
Move expensive operations (sorting, filtering, networking) to a view model or background task. `body` is called frequently.

```swift
// ❌ Sorted on every render
var body: some View {
    List(items.sorted()) { ... }
}

// ✅ Sorted once, cached in the view model
@StateObject private var vm = ItemViewModel()
var body: some View {
    List(vm.sortedItems) { ... }
}
```

### 7. Use `task` and `async`/`await` for async work
Prefer the `.task` modifier over `.onAppear` + `DispatchQueue` for cleaner lifecycle management and automatic cancellation.

```swift
.task {
    await viewModel.loadData()
}
```

### 8. Profile with Instruments
Use **Xcode Instruments → SwiftUI** template to:
- Identify views that re-render too often
- Spot long `body` evaluation times
- Catch redundant state updates

---

## 🤝 Contributing

1. Fork the repository and create a feature branch.
2. Document your change in `CHANGELOG.md` under `[Unreleased]`.
3. Open a pull request — CI will validate the build, tests, and lint automatically.

