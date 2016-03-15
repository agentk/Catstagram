import ReSwift

struct FeedUpdateItem {
    let type: UpdateType
    let item: FeedItem

    init(type: UpdateType, item: FeedItem) {
        self.type = type
        self.item = item
    }
}

extension FeedUpdateItem: Coding {
    init(dictionary: [String : AnyObject]) {
        self.type = UpdateType(rawValue: dictionary["type"] as? String ?? "") ?? .Add
        self.item = FeedItem(dictionary: dictionary["item"] as? [String: AnyObject] ?? [:])
    }

    func dictionaryRepresentation() -> [String : AnyObject] {
        return [
            "type": type.rawValue,
            "item": item.dictionaryRepresentation(),
        ]
    }
}

enum FeedAction {
    case SelectItem(Int)
    case HeartItem(Int)
    case UnheartItem(Int)
    case ArchiveItem(Int)
    case UnarchiveItem(Int)

    case RefreshFeed(userInitiated: Bool)
    case EndRefreshFeed

    case MassItemUpdate([FeedUpdateItem])

    static let type = "FeedAction"
}

extension FeedAction: StandardActionConvertible {

    func payload() -> [String: AnyObject] {
        switch self {
        case .SelectItem(let value):
            return ["case": "SelectItem", "value": value]

        case .HeartItem(let value):
            return ["case": "HeartItem", "value": value]

        case .UnheartItem(let value):
            return ["case": "UnheartItem", "value": value]

        case .ArchiveItem(let value):
            return ["case": "ArchiveItem", "value": value]

        case .UnarchiveItem(let value):
            return ["case": "UnarchiveItem", "value": value]

        case .RefreshFeed(let value):
            return ["case": "RefreshFeed", "value": value]

        case .EndRefreshFeed:
            return ["case": "EndRefreshFeed"]

        case .MassItemUpdate(let data):
            return [
                "case": "MassItemUpdate",
                "data": data.map { $0.dictionaryRepresentation() }
            ]

        }
    }

    // swiftlint:disable:next cyclomatic_complexity
    init (_ standardAction: StandardAction) {

        guard let payload = standardAction.payload else {
            fatalError("Unable to decode standardAction.payload: \(standardAction)")
        }

        guard let caseType = payload["case"] as? String else {
            fatalError("Unable to decode standardAction.payload.case: \(standardAction)")
        }

        switch caseType {
        case "SelectItem":
            guard let value = payload["value"] as? Int else {
                fatalError("Unable to decode standardAction.payload.value: \(standardAction)")
            }
            self = .SelectItem(value)

        case "HeartItem":
            guard let value = payload["value"] as? Int else {
                fatalError("Unable to decode standardAction.payload.value: \(standardAction)")
            }
            self = .HeartItem(value)

        case "UnheartItem":
            guard let value = payload["value"] as? Int else {
                fatalError("Unable to decode standardAction.payload.value: \(standardAction)")
            }
            self = .UnheartItem(value)

        case "ArchiveItem":
            guard let value = payload["value"] as? Int else {
                fatalError("Unable to decode standardAction.payload.value: \(standardAction)")
            }
            self = .ArchiveItem(value)

        case "UnarchiveItem":
            guard let value = payload["value"] as? Int else {
                fatalError("Unable to decode standardAction.payload.value: \(standardAction)")
            }
            self = .UnarchiveItem(value)

        case "RefreshFeed":
            guard let value = payload["value"] as? Bool else {
                fatalError("Unable to decode standardAction.payload.value: \(standardAction)")
            }
            self = .RefreshFeed(userInitiated: value)

        case "EndRefreshFeed":
            self = .EndRefreshFeed

        case "MassItemUpdate":
            guard let data = payload["value"] as? [[String: AnyObject]] else {
                fatalError("Unable to decode standardAction.payload.value: \(standardAction)")
            }
                self = .MassItemUpdate(data.map { FeedUpdateItem(dictionary: $0) })

        default:
            fatalError("Unable to swift caseType standardAction.payload.path: \(standardAction)")
        }
    }

    func toStandardAction() -> StandardAction {
        return StandardAction(type: FeedAction.type, payload: payload(), isTypedAction: true)
    }
}
