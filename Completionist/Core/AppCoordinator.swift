import UIKit
import FeatherweightRouter
import ReSwift
import ReactiveKit

class AppCoordinator {

    let store: AppStore
    let router: Router<UIViewController>
    let viewController: UIViewController

    let bag = DisposeBag()

    init() {
        store = ObservableStore(
            reducer: AppReducer(),
            state: AppState(),
            middleware: [])

        router = appRouter(store)
        viewController = router.presenter

        subscribeRouterToUpdates()

        setInitialRoute()
    }

    func subscribeRouterToUpdates() {
        store.map { $0.route }.observe { [unowned self] route in
            self.router.setRoute(route)
            }.disposeIn(bag)
    }

    func setInitialRoute() {
        store.dispatch(RouteAction.Set(path: "inbox"))
    }
}
