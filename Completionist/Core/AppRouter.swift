import UIKit
import FeatherweightRouter

typealias UIRouterCreator = AppStore -> UIRouter
typealias UIPresenterCreator = AppStore -> UIPresenter

func appRouter(store: AppStore) -> UIRouter {

    // swiftlint:disable todo
    // TODO: Refactor out into section functions

    let defaultTabBarRoutes = ["feed", "history", "settings"]

    return Router(tabBarPresenter(store, fallbackRoutes: defaultTabBarRoutes)).junction([

        Router(navigationPresenter("Feed")).stack([
            Router(feedListPresenter(store)).route("feed", children: [
                Router(feedItemPresenter(store)).route("photo/(?<id>\\w+)"),
                ]),
            ]),

        Router(navigationPresenter("History")).stack([
            Router(mockPresenter(
                store,
                backgroundColor: (64, 128, 64),
                title: "History",
                callToActionTitle: "FEED",
                callToActionRoute: "feed")
                ).route("history"),
            ]),

        Router(navigationPresenter("Settings")).stack([
            Router(mockPresenter(
                store,
                backgroundColor: (128, 128, 64),
                title: "Settings",
                callToActionTitle: "FEED",
                callToActionRoute: "feed")
                ).route("settings"),
            ]),

        ])
}
