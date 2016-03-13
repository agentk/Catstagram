//import UIKit
import FeatherweightRouter

func feedItemPresenter(store: AppStore) -> UIPresenter {


    let viewController = MockViewController(MockViewModel(
        store: store,
        backgroundColor: (0, 64, 128),
        title: "FEED ITEM",
        callToActionTitle: "404",
        callToActionRoute: "feed"))

    return RouterDelegate(getPresenter: { viewController })
}
