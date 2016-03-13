import UIKit
import FeatherweightRouter

typealias UIRouterCreator = AppStore -> UIRouter
typealias UIPresenterCreator = AppStore -> UIPresenter

func appRouter(store: AppStore) -> UIRouter {

    // swiftlint:disable todo
    // TODO: Refactor out onto delcerative functions

    return Router(tabBarPresenter(store)).junction([

        Router(navigationPresenter("Feed")).stack([

            Router(feedListPresenter(store)).route("feed", children: [
                Router(feedItemPresenter(store)).route("photo/(?<id>\\w+)"),
                ]),
            ]),

        Router(navigationPresenter("Options")).stack([

            Router(feedListPresenter(store)).route("options"),
            ]),

        ])
}
