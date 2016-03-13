struct FeedListOutputDispatch: FeedListOutput {

    let dispatch: Dispatcher

    init(dispatch: Dispatcher) {
        self.dispatch = dispatch
    }

    func didSelectItem(item: FeedItem) {
        dispatch(FeedAction.SelectItem(item: item))
    }

    func refreshList() {
        dispatch(FeedAction.RefreshFeed(userInitiated: true))
    }

}
