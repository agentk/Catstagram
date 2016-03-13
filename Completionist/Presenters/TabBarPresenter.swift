import UIKit
import FeatherweightRouter

func tabBarPresenter(store: AppStore) -> UIPresenter {

    let tabBarController = SuperTabBarController()
    var lastUsedRoutes = [String: String]()

//    tabBarController.didSelectViewController = { child in
//        if let route = lastUsedRoutes[String(child)] {
//            store.dispatch(RouteAction.Set(path: route))
//        }
//    }

    func currentRoute() -> String {
        return store.state.route
    }

    func rememberLastUsedRouteFor(child child: UIViewController, route: String) {
        lastUsedRoutes[String(child)] = route
    }

    func setChild(child: UIViewController) {
        tabBarController.selectedViewController = child
        rememberLastUsedRouteFor(child: child, route: currentRoute())
    }

    func setChildren(children: [UIViewController]) {
        tabBarController.setViewControllers(children, animated: true)
    }

    return RouterDelegate(
        getPresenter: { tabBarController },
        setChild: setChild,
        setChildren: setChildren)
}

class SuperTabBarController: UITabBarController, UITabBarControllerDelegate {

    var didSelectViewController: (UIViewController -> Void)? = nil

    override func viewDidLoad() {
        delegate = self
    }

    func tabBarController(tabBarController: UITabBarController,
        didSelectViewController viewController: UIViewController) {
            didSelectViewController?(viewController)
    }
}

protocol TabPresenter {
    var selectAction: UIViewController -> Void { get }
    func selectedVC()
}

//extension UITabBarController: TabPresenter {
//
//    var selectedAction: UIViewController -> Void {
//        return { _ in }
//    }
//
//    func selectedVC() { }
//}
