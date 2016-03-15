import UIKit
import FeatherweightRouter

func navigationPresenter(title: String) -> UIPresenter {

    let blankView = UIViewController()

    let navigationController = UINavigationController(rootViewController: blankView)
    navigationController.tabBarItem.title = title
    let tabImageName = title.lowercaseString.stringByReplacingOccurrencesOfString(
        " ", withString: "-")
    navigationController.tabBarItem.image = UIImage(named: "\(tabImageName)-icon")

    func setChildren(children: [UIViewController]) {
        let children = children.count == 0 ? [blankView] : children
        navigationController.setViewControllers(children, animated: true)
    }

    return RouterDelegate(
        getPresenter: { navigationController },
        setChild: { _ in },
        setChildren: setChildren)
}
