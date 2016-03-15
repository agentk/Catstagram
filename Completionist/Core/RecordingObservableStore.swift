import ReSwift
import ReactiveKit

//public typealias TypeMap = [String: StandardActionConvertible.Type]

class RecordingObservableStore<State: StateType>: ObservableStore<State> {

    typealias RecordedActions = [[String : AnyObject]]

    var initialState: State!
    var actionHistory: [Action] = []
    var actionCount: Int = 0

    var recordedActions: RecordedActions = []
    let recordingPath: String?
//    private var typeMap: TypeMap = [:]

    lazy var recordingDirectory: NSURL? = {
        let timestamp = Int(NSDate.timeIntervalSinceReferenceDate())

        let documentDirectoryURL = try? NSFileManager.defaultManager()
            .URLForDirectory(
                .DocumentDirectory,
                inDomain: .UserDomainMask,
                appropriateForURL: nil,
                create: true)

        let path = documentDirectoryURL?
            .URLByAppendingPathComponent("recording.json")

        print("Recording to path: \(path)")
        return path
    }()

    lazy var documentsDirectory: NSURL? = {
        let documentDirectoryURL = try? NSFileManager.defaultManager()
            .URLForDirectory(.DocumentDirectory, inDomain:
                .UserDomainMask, appropriateForURL: nil, create: true)

        return documentDirectoryURL
    }()


//    required init(reducer: AnyReducer, state: State, middleware: [Middleware],
//                  typeMaps: [TypeMap], recordingPath: String? = nil) {
    required init(reducer: AnyReducer, state: State, middleware: [Middleware],
                  recordingPath: String? = nil) {

        initialState = state
        self.recordingPath = recordingPath

        super.init(reducer: reducer, state: state, middleware: middleware)

        // merge all typemaps into one
//        typeMaps.forEach { typeMap in
//            for (key, value) in typeMap {
//                self.typeMap[key] = value
//            }
//        }

//        if let recordingPath = recordingPath {
//            actionHistory = loadActions(recordingPath)
//            replayToActionCount(actionHistory.count)
//        }
    }

    // MARK: - Recording

    internal override func _defaultDispatch(action: Action) -> Any {
        if isDispatching {
            // Use Obj-C exception since throwing of exceptions can be verified through tests
            NSException.raise("SwiftFlow:IllegalDispatchFromReducer", format: "Reducers may not " +
                "dispatch actions.", arguments: getVaList(["nil"]))
        }

        var oldState = state

        if actionCount != actionHistory.count {
            oldState = actionHistory.reduce(initialState) { state, action in
                // swiftlint:disable:next force_cast
                return self.reducer._handleAction(action, state: state) as! State
            }
        }

        recordAction(action)

        isDispatching = true
        // swiftlint:disable:next force_cast
        let newState = reducer._handleAction(action, state: oldState) as! State
        isDispatching = false

        state = newState
        actionCount = actionHistory.count

        return action
    }




    func recordAction(action: Action) {
        guard let standardAction = convertActionToStandardAction(action) else {
            return print("ReSwiftRecorder Warning: Could not log following action because it " +
                "does not conform to StandardActionConvertible: \(action)")
        }

        let recordedAction: [String: AnyObject] = [
            "timestamp": NSDate.timeIntervalSinceReferenceDate(),
            "action": standardAction.dictionaryRepresentation()
        ]

        recordedActions.append(recordedAction)
        storeActions(recordedActions)
    }


    private func convertActionToStandardAction(action: Action) -> StandardAction? {

        if let standardAction = action as? StandardAction {
            return standardAction
        } else if let standardActionConvertible = action as? StandardActionConvertible {
            return standardActionConvertible.toStandardAction()
        }

        return nil
    }

    private func storeActions(actions: RecordedActions) {
        guard let data = try? NSJSONSerialization.dataWithJSONObject(
            actions, options: .PrettyPrinted) else {
                return print("ReSwiftRecorder Warning: Unable to storeActions, actions could not " +
                    "be serialized")
        }

        if let path = recordingDirectory {
            data.writeToURL(path, atomically: true)
        }
    }

    // MARK: - Reload

//    private func loadActions(recording: String) -> [Action] {
//        guard let recordingPath = documentsDirectory?.URLByAppendingPathComponent(recording)
//    else {
//                return []
//        }
//
//        guard let data = NSData(contentsOfURL: recordingPath) else { return [] }
//
//        guard let jsonArray = try? NSJSONSerialization.JSONObjectWithData(
//            data, options: NSJSONReadingOptions(rawValue: 0)) as? Array<AnyObject> else {
//                return []
//        }
//
//        let actionsArray: [Action] = jsonArray?.flatMap { item in
//            if let item = item["action"] as? [String : AnyObject] {
//                return decodeAction(item)
//            }
//            return nil
//            } ?? []
//
//        return actionsArray
//    }


    // MARK: - Replay

//    private func decodeAction(jsonDictionary: [String : AnyObject]) -> Action {
//        let standardAction = StandardAction(dictionary: jsonDictionary)
//
//        if !standardAction.isTypedAction {
//            return standardAction
//        } else {
//            let typedActionType = self.typeMap[standardAction.type]!
//            return typedActionType.init(standardAction)
//        }
//    }

    private func replayToActionCount(actionCount: Int) {
        self.actionCount = actionCount

        state = actionHistory[0..<actionCount].reduce(initialState) { state, action in
            // swiftlint:disable:next force_cast
            return self.reducer._handleAction(action, state: state) as! State
        }
    }

}
