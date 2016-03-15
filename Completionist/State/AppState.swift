import ReSwift

struct AppState: StateType {
    var counter: Int = 0
    var route: String = "feed"
    var feedItems = [FeedItem]()
    var refreshingFeed = false
    var users = [User]()
}
