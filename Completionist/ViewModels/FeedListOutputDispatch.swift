struct FeedListOutputDispatch: FeedListOutput {

    let dispatch: Dispatcher

    init(dispatch: Dispatcher) {
        self.dispatch = dispatch
    }

    func didSelectItem(itemId: Int) {
        dispatch(FeedAction.SelectItem(itemId))
    }

    func refreshList() {
        dispatch(FeedAction.RefreshFeed(userInitiated: true))
    }

    func didHeartItem(itemId: Int) {
        dispatch(FeedAction.HeartItem(itemId))
    }

    func didUnarchiveItem(itemId: Int) {
        dispatch(FeedAction.UnarchiveItem(itemId))
    }

    func didArchiveItem(itemId: Int) {
        dispatch(FeedAction.ArchiveItem(itemId))
    }

    func didUnheartItem(itemId: Int) {
        dispatch(FeedAction.UnheartItem(itemId))
    }

}
