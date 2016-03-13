import UIKit
import FeatherweightRouter
import ReSwift
import ReactiveKit

class AppCoordinator {


    let store: AppStore
    let router: Router<UIViewController>
    let viewController: UIViewController

    let bag = DisposeBag()

    init(state: AppState? = nil, feedService: FeedProviderService) {

        store = ObservableStore(
            reducer: AppReducer(),
            state: state ?? AppState(),
            middleware: [
                makeFeedListMiddleware(feedService),
                makeUserMiddleware(feedService),
            ])

        router = appRouter(store)
        viewController = router.presenter

        subscribeRouterToUpdates()
    }

    deinit {
        bag.dispose()
    }

    func subscribeRouterToUpdates() {
        store.map { $0.route }.distinct().observe { [unowned self] route in
            if route == "" { return }
            self.router.setRoute(route)
        }.disposeIn(bag)
    }
}
