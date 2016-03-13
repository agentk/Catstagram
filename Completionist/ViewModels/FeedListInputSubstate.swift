import ReactiveKit

class FeedListInputSubstate: FeedListInput {

    let items = ObservableCollection<[FeedItem]>([])
    let isRefreshing = Observable(false)

    init(state: ObservableState) {

        state.map { [unowned self] state in
                self.normalizeItems(state.feedItems, users: state.users) }
            .observe { newItems in
                self.items.replace(newItems, performDiff: true) }

        state.map { $0.refreshingFeed }.distinct().bindTo(isRefreshing)
    }

    func normalizeItems(items: [FeedItem], users: [User]) -> [FeedItem] {
        return items
            .filter { $0.unread }
            .sort(descendingCreatedTime)
            .map(normalizeUsername(users))
    }

    func descendingCreatedTime(lhs: FeedItem, rhs: FeedItem) -> Bool {
        return lhs.createdTime < rhs.createdTime
    }

    func normalizeUsername(users: [User]) -> FeedItem -> FeedItem {
        return { item in
            var item = item
            let user = users.filter { $0.id == item.userId }.first
            item.username = "@" + (user?.username ?? "...")
            return item
        }
    }
}
