protocol FeedProviderService {

    func updateFeed(callback: [FeedUpdateItem]? -> Void)

    func itemDetail(itemId: Int, callback: FeedItem? -> Void)

    // swiftlint:disable variable_name
    func getUser(id: Int, callback: User? -> Void)
}

enum UpdateType: String {
    case Add
    case Update
    case Delete
}
