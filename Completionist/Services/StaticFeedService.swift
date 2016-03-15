import Foundation

class StaticFeedService: FeedProviderService {

    func updateFeed(callback: [FeedUpdateItem]? -> Void) {

        let count = Int(arc4random_uniform(4))
        var results = [FeedUpdateItem]()
        for _ in 0...count {
            var item = FeedItem()
            item.userId = Int(arc4random_uniform(UInt32(DummyData.usernames.count)))
            results.append(FeedUpdateItem(type: .Add, item: item))
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
