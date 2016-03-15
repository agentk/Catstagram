import ReSwift


enum FeedItemType: String {
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
        id = FeedItem.currentIndex
        FeedItem.currentIndex += 1
    }


    static var currentIndex = 0

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


extension FeedItem: Coding {

    init(dictionary: [String: AnyObject]) {
        type = FeedItemType.init(
            rawValue: dictionary["type"] as? String ?? "") ?? .Image
        id = dictionary["id"] as? Int ?? -1
        userId = dictionary["userId"] as? Int ?? -1
        username = dictionary["username"] as? String ?? ""
        caption = dictionary["caption"] as? String ?? ""
        commentCount = dictionary["commentCount"] as? Int ?? 0
        likeCount = dictionary["likeCount"] as? Int ?? 0
        tags = dictionary["tags"] as? [String] ?? []
        link = dictionary["link"] as? String ?? ""
        createdTime = dictionary["createdTime"] as? Int ?? 0
        if let imageData = dictionary["images"] as? [[String: AnyObject]] {
            images = imageData.map(FeedImage.init)
        }
        unread = dictionary["unread"] as? Bool ?? false
    }

    func dictionaryRepresentation() -> [String : AnyObject] {
        return [
            "type": type.rawValue,
            "id": id,
            "userId": userId,
            "username": username,
            "caption": caption,
            "commentCount": commentCount,
            "likeCount": likeCount,
            "tags": tags,
            "link": link,
            "createdTime": createdTime,
            "images": images.map { $0.dictionaryRepresentation() },
            "unread": unread,
        ]
    }
}
