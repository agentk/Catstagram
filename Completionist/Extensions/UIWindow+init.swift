import UIKit

extension UIWindow {

    convenience init(frame: CGRect? = nil, rootViewController: UIViewController) {
        self.init(frame: frame ?? UIScreen.mainScreen().bounds)
        self.rootViewController = rootViewController
    }

}
