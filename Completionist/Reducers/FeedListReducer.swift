import ReSwift

func feedListReducer(action: Action, state: AppState) -> AppState {

    var state = state

    switch action {
    case .RefreshFeed(let userInitiated) as FeedAction where userInitiated:
        state.refreshingFeed = true

    case .EndRefreshFeed as FeedAction:
        state.refreshingFeed = false

    case .MassItemUpdate(let updates) as FeedAction:

        for (type, feedItem) in updates {
            switch type {
            case .Add:
                state.feedItems.append(feedItem)
            case .Update: break
            case .Delete: break
            }
        }

    default: break
    }

    return state
}
