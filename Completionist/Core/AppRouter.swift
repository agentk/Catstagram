import UIKit
import FeatherweightRouter

func appRouter(store: AppStore) -> UIRouter {
    return Router(tabBarPresenter()).junction([
        Router(navigationPresenter("Inbox")).stack([recordRoutes(store)]),
        Router(navigationPresenter("History")).stack([historyRoutes(store)]),
        ])
}

func recordRoutes(store: AppStore) -> UIRouter {
    let presenter = mockPresenter(
        store,
        backgroundColor: (64, 64, 128),
        title: "Inbox",
        callToActionTitle: "-> history",
        callToActionRoute: "history")

    return Router(presenter).route("inbox")
}

func historyRoutes(store: AppStore) -> UIRouter {
    let presenter = mockPresenter(
        store,
        backgroundColor: (64, 64, 128),
        title: "History",
        callToActionTitle: "-> inbox",
        callToActionRoute: "inbox")

    return Router(presenter).route("history")
}
