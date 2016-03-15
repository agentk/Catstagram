import ReSwift

enum UserAction {
    case UpdateUsers([Int])
    case MassUpdateUsers([User])

    static let type = "UserAction"
}

extension UserAction: StandardActionConvertible {

    func payload() -> [String: AnyObject] {
        switch self {
        case .UpdateUsers(let value):
            return ["case": "UpdateUsers", "value": value]
        case .MassUpdateUsers(let value):
            return ["case": "MassUpdateUsers", "value": value.map { $0.dictionaryRepresentation() }]
        }
    }

    init (_ standardAction: StandardAction) {

        guard let payload = standardAction.payload else {
            fatalError("Unable to decode standardAction.payload: \(standardAction)")
        }

        guard let caseType = payload["case"] as? String else {
            fatalError("Unable to decode standardAction.payload.case: \(standardAction)")
        }

        switch caseType {
        case "UpdateUsers":
            guard let value = payload["value"] as? [Int] else {
                fatalError("Unable to decode standardAction.payload.value: \(standardAction)")
            }
            self = .UpdateUsers(value)

        case "MassUpdateUsers":
            guard let value = payload["value"] as? [[String: AnyObject]] else {
                fatalError("Unable to decode standardAction.payload.value: \(standardAction)")
            }
            self = .MassUpdateUsers(value.map(User.init))

        default:
            fatalError("Unable to swift caseType standardAction.payload.path: \(standardAction)")
        }
    }

    func toStandardAction() -> StandardAction {
        return StandardAction(type: UserAction.type, payload: payload(), isTypedAction: true)
    }
}
