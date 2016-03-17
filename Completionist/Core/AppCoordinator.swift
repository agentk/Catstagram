import UIKit
import FeatherweightRouter
import ReSwift
import ReactiveKit
import SocketIOClientSwift

class AppCoordinator {


    var store: AppStore!
    let router: Router<UIViewController>
    let viewController: UIViewController
    let devSocket: SocketIOClient

    let bag = DisposeBag()

    init(state: AppState? = nil, feedService: FeedProviderService, socket: SocketIOClient) {

        devSocket = socket

        #if DEBUG
            store = RecordingObservableStore(
                reducer: AppReducer(),
                state: state ?? AppState(),
                middleware: [
                    makeFeedListMiddleware(feedService),
                    makeUserMiddleware(feedService),
                ],
                typeMap: [
                    "RouteAction": RouteAction.self,
                    "FeedAction": FeedAction.self,
                    "UserAction": UserAction.self,
                ],
                socket: devSocket)
        #else
            store = ObservableStore(
                reducer: AppReducer(),
                state: state ?? AppState(),
                middleware: [
                    makeFeedListMiddleware(feedService),
                    makeUserMiddleware(feedService),
                ])
        #endif

        router = appRouter(store)
        viewController = router.presenter

        subscribeRouterToUpdates()
    }

    deinit {
        if let store = store as? RecordingObservableStore {
            print("Calling disconnect")
            store.disconnect()
        }
        store = nil
        bag.dispose()
    }

    func subscribeRouterToUpdates() {
        store.map { $0.route }.distinct().observe { [unowned self] route in
            if route == "" { return }
            self.router.setRoute(route)
        }.disposeIn(bag)
    }
}
