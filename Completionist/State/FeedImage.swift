import ReSwift

enum FeedImageSizeClass: String {
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

extension FeedImage: Coding {

    init(dictionary: [String : AnyObject]) {
        sizeClass = FeedImageSizeClass.init(
            rawValue: dictionary["sizeClass"] as? String ?? "") ?? .Thumbnail
        url = dictionary["url"] as? String ?? ""
        width = dictionary["width"] as? Int ?? 0
        height = dictionary["height"] as? Int ?? 0
    }

    func dictionaryRepresentation() -> [String : AnyObject] {
        return [
            "sizeClass": sizeClass.rawValue,
            "url": url,
            "width": width,
            "height": height,
        ]
    }

}
