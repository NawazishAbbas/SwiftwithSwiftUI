// SwiftUIPerformanceTips.swift
// SwiftwithSwiftUI
//
// Annotated examples of the most impactful SwiftUI performance patterns.
// Each section maps to the matching tip in README.md.

import SwiftUI
import Combine

// MARK: - Tip 2: Equatable views skip unnecessary redraws

struct User: Identifiable, Equatable {
    let id: UUID
    var name: String
    var avatarURL: URL?
}

/// Conforming to `Equatable` lets SwiftUI compare old and new props.
/// If they are equal the `body` is NOT re-evaluated — zero wasted work.
struct UserRow: View, Equatable {
    let user: User

    var body: some View {
        HStack {
            AsyncImage(url: user.avatarURL)
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            Text(user.name)
                .font(.headline)
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Tip 3: Decompose large views into focused subviews

/// ❌  A monolithic view re-evaluates everything whenever `count` changes.
struct MonolithicDashboard: View {
    @State private var count = 0

    var body: some View {
        VStack(spacing: 16) {
            // Header — re-evaluated even though it doesn't use `count`
            Text("Dashboard")
                .font(.largeTitle)
                .bold()

            // Counter — correctly depends on `count`
            Text("Taps: \(count)")

            // Footer — re-evaluated even though it doesn't use `count`
            Text("SwiftwithSwiftUI © 2026")
                .font(.caption)
                .foregroundStyle(.secondary)

            Button("Tap me") { count += 1 }
        }
        .padding()
    }
}

/// ✅  Decomposed: only `CounterSection` re-renders when `count` changes.
struct DecomposedDashboard: View {
    @State private var count = 0

    var body: some View {
        VStack(spacing: 16) {
            HeaderSection()
            CounterSection(count: count)
            FooterSection()
            Button("Tap me") { count += 1 }
        }
        .padding()
    }
}

private struct HeaderSection: View {
    var body: some View {
        Text("Dashboard")
            .font(.largeTitle)
            .bold()
    }
}

private struct CounterSection: View {
    let count: Int
    var body: some View {
        Text("Taps: \(count)")
    }
}

private struct FooterSection: View {
    var body: some View {
        Text("SwiftwithSwiftUI © 2026")
            .font(.caption)
            .foregroundStyle(.secondary)
    }
}

// MARK: - Tip 4: @StateObject vs @ObservedObject

final class ItemViewModel: ObservableObject {
    @Published private(set) var sortedItems: [String] = []

    func load(items: [String]) {
        // Sorting is done once, off the hot path.
        sortedItems = items.sorted()
    }
}

/// ✅  `@StateObject` — owned by this view; SwiftUI guarantees a stable lifetime.
struct ItemListView: View {
    @StateObject private var viewModel = ItemViewModel()

    private let rawItems = ["Banana", "Apple", "Cherry", "Date"]

    var body: some View {
        List(viewModel.sortedItems, id: \.self) { item in
            Text(item)
        }
        .onAppear {
            viewModel.load(items: rawItems)
        }
    }
}

// MARK: - Tip 5: LazyVStack for long lists

struct FeedView: View {
    let posts: [String]

    var body: some View {
        ScrollView {
            // Only renders rows as they scroll into view — O(visible) not O(total).
            LazyVStack(spacing: 12) {
                ForEach(posts, id: \.self) { post in
                    PostCard(text: post)
                }
            }
            .padding()
        }
    }
}

private struct PostCard: View {
    let text: String
    var body: some View {
        Text(text)
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.quaternary, in: RoundedRectangle(cornerRadius: 12))
    }
}

// MARK: - Tip 6: Move heavy work out of `body`

/// ❌  Sorts on every body evaluation — O(n log n) per frame.
struct SortedListBad: View {
    let items: [String]
    var body: some View {
        List(items.sorted(), id: \.self) { Text($0) }
    }
}

/// ✅  Sorting is done once in the view model; `body` just reads a cached array.
struct SortedListGood: View {
    @StateObject private var vm = SortViewModel()
    let items: [String]

    var body: some View {
        List(vm.sortedItems, id: \.self) { Text($0) }
            .onAppear { vm.sort(items) }
    }
}

final class SortViewModel: ObservableObject {
    @Published private(set) var sortedItems: [String] = []
    func sort(_ items: [String]) { sortedItems = items.sorted() }
}

// MARK: - Tip 7: `.task` for async work

struct ArticleListView: View {
    @State private var articles: [String] = []
    @State private var isLoading = false

    var body: some View {
        Group {
            if isLoading {
                ProgressView("Loading…")
            } else {
                List(articles, id: \.self) { Text($0) }
            }
        }
        // `.task` is automatically cancelled when the view disappears —
        // no manual cancellation boilerplate needed.
        .task {
            isLoading = true
            articles = await fetchArticles()
            isLoading = false
        }
    }

    private func fetchArticles() async -> [String] {
        // Simulated network delay
        try? await Task.sleep(for: .seconds(1))
        return ["Swift 6 Concurrency", "SwiftData Deep Dive", "Observable Macro"]
    }
}
