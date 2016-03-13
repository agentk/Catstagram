import ReSwift

enum FeedAction: Action {
    case SelectItem(item: FeedItem)

    case RefreshFeed(userInitiated: Bool)
    case EndRefreshFeed

    case MassItemUpdate([(UpdateType, FeedItem)])

}
