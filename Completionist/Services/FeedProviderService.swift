protocol FeedProviderService {

    func updateFeed(callback: [(UpdateType, FeedItem)]? -> Void)

    func itemDetail(itemId: Int, callback: FeedItem? -> Void)

    // swiftlint:disable variable_name
    func getUser(id: Int, callback: User? -> Void)
}

enum UpdateType {
    case Add
    case Update
    case Delete
}
