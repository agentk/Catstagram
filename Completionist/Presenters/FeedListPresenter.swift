import UIKit
import FeatherweightRouter
import ReactiveKit

func feedListPresenter(store: AppStore) -> UIPresenter {

    let viewController = FeedListViewController(
        input: FeedListInputSubstate(state: store.observable),
        output: FeedListOutputDispatch(dispatch: store.dispatchAction))

    return RouterDelegate(getPresenter: { viewController })
}
