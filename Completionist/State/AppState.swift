import ReSwift

struct AppState: StateType {
    var counter: Int = 0
    var route: String = "feed"
    var feedItems = [FeedItem]()
    var refreshingFeed = false
    var users = [User]()
}

enum FeedItemType {
    case Image
    case Video
}

struct FeedItem: Equatable {

    var type: FeedItemType = .Image

    // swiftlint:disable variable_name
    var id = 0
    var userId = 0
    var username = ""

    var caption = "Some caption"
    var commentCount = 0
    var likeCount = 0
    var tags = [String]()
    var link = ""
    var createdTime = 0
    var images = [FeedImage()]

    var unread: Bool = true

    init() {
        createdTime = randomRecentTime()
    }

    func randomRecentTime() -> Int {
        let randomHour = 0 - Int(arc4random_uniform(60*60))
        let randomInterval = NSTimeInterval(randomHour)
        let date = NSDate(timeIntervalSinceNow: randomInterval)
        return Int(date.timeIntervalSince1970)
    }

}

func == (lhs: FeedItem, rhs: FeedItem) -> Bool {
    return String(lhs) == String(rhs)
}


enum FeedImageSizeClass {
    case Thumbnail
    case Low
    case Original
}

struct FeedImage {
    var sizeClass: FeedImageSizeClass = .Original
    var url = "cat-1"
    var width = 0
    var height = 0

    init() {
        let randId = arc4random_uniform(18)
        url = "cat-\(randId)"
    }
}

struct User {
    // swiftlint:disable variable_name
    var id = 0
    var username = ""
    var fullName = ""
    var profilePicture = ""
    var bio = ""
    var website = ""
    var mediaCount = 0
    var followsCount = 0
    var followedByCount = 0
}
