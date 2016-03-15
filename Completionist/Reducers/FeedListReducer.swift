import ReSwift

func feedListReducer(action: Action, state: AppState) -> AppState {

    var state = state

    switch action {
    case .RefreshFeed(let userInitiated) as FeedAction where userInitiated:
        state.refreshingFeed = true

    case .EndRefreshFeed as FeedAction:
        state.refreshingFeed = false

    case .MassItemUpdate(let updates) as FeedAction:

        for update in updates {
            switch update.type {
            case .Add:
                state.feedItems.append(update.item)
            case .Update: break
            case .Delete: break
            }
        }

    case .ArchiveItem(let itemId) as FeedAction:
        state.feedItems = state.feedItems.map { item in
            guard item.id == itemId else { return item }
            var item = item
            item.unread = false
            return item
        }

    default: break
    }

    return state
}
