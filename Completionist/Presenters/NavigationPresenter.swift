import UIKit
import FeatherweightRouter

func navigationPresenter(title: String) -> UIPresenter {

    let navigationController = UINavigationController()
    navigationController.tabBarItem.title = title
//    navigationController.tabBarItem.image = UIImage(named: "placeholder-icon")

    func setChildren(children: [UIViewController]) {
        navigationController.setViewControllers(children, animated: true)
    }

    return RouterDelegate(
        getPresenter: { navigationController },
        setChild: { _ in },
        setChildren: setChildren)
}
