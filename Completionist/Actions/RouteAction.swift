import ReSwift

enum RouteAction {
    case Set(path: String)

    static let type = "RouteAction"
}

extension RouteAction: StandardActionConvertible {

    func payload() -> [String: AnyObject] {
        switch self {
        case .Set(let path):
            return ["case": "Set", "path": path]
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
        case "Set":
            guard let path = payload["path"] as? String else {
                fatalError("Unable to decode standardAction.payload.path: \(standardAction)")
            }
            self = .Set(path: path)

        default:
            fatalError("Unable to swift caseType standardAction.payload.path: \(standardAction)")
        }
    }

    func toStandardAction() -> StandardAction {
        return StandardAction(type: RouteAction.type, payload: payload(), isTypedAction: true)
    }
}
