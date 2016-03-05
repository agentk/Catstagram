import UIKit
import FeatherweightRouter

func mockPresenter(store: AppStore,
                   backgroundColor: (Int, Int, Int),
                   title: String,
                   callToActionTitle: String,
                   callToActionRoute: String) -> UIPresenter {

    let viewController = MockViewController(MockViewModel(
        store: store,
        backgroundColor: backgroundColor,
        title: title,
        callToActionTitle: callToActionTitle,
        callToActionRoute: callToActionRoute))

    return RouterDelegate(getPresenter: { viewController})
}
