struct FeedRefreshActionCreator {

    static func refresh(dispatch: Dispatcher) {
        delay(2) {
            dispatch(FeedAction.EndRefreshFeed)
        }
    }
}
