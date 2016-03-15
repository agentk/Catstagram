import ReSwift

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

extension User: Coding {

    init(dictionary: [String: AnyObject]) {
        id = dictionary["id"] as? Int ?? 0
        username = dictionary["username"] as? String ?? ""
        fullName = dictionary["fullName"] as? String ?? ""
        profilePicture = dictionary["profilePicture"] as? String ?? ""
        bio = dictionary["bio"] as? String ?? ""
        website = dictionary["website"] as? String ?? ""
        mediaCount = dictionary["mediaCount"] as? Int ?? 0
        followsCount = dictionary["followsCount"] as? Int ?? 0
        followedByCount = dictionary["followedByCount"] as? Int ?? 0
    }

    func dictionaryRepresentation() -> [String : AnyObject] {
        return [
            "id": id,
            "username": username,
            "fullName": fullName,
            "profilePicture": profilePicture,
            "bio": bio,
            "website": website,
            "mediaCount": mediaCount,
            "followsCount": followsCount,
            "followedByCount": followedByCount,
        ]
    }
}
