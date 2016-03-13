import ReSwift

func userReducer(action: Action, users: [User]) -> [User] {

    switch action {
    case .MassUpdateUsers(let newUsers) as UserAction:
        print(newUsers)
        let newIds = newUsers.map { $0.id }
        return newUsers + users.filter { !newIds.contains($0.id) }

    default: break
    }

    return users
}
