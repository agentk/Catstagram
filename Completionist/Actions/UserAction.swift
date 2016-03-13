import ReSwift

enum UserAction: Action {
    case UpdateUsers([Int])
    case MassUpdateUsers([User])
}
