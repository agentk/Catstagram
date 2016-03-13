import Foundation

class StaticFeedService: FeedProviderService {

    func updateFeed(callback: [(UpdateType, FeedItem)]? -> Void) {

        let count = Int(arc4random_uniform(4))
        var results = [(UpdateType, FeedItem)]()
        for _ in 0...count {
            var item = FeedItem()
            item.userId = Int(arc4random_uniform(UInt32(DummyData.usernames.count)))
            results.append((UpdateType.Add, item))
        }

        callback(results)
    }

    func itemDetail(itemId: Int, callback: FeedItem? -> Void) {

    }

    func getUser(userId: Int, callback: User? -> Void) {
        guard DummyData.usernames.count > userId else { return callback(nil) }

        var user = User()
        user.id = userId
        user.username = DummyData.usernames[userId]

        callback(user)
    }

}
