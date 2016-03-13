import ReSwift

let makeFeedListMiddleware: FeedProviderService -> Middleware = { feedService in {
    dispatch, getState in { next in { action in

        let result = next(action)

        switch action {
        case .RefreshFeed as FeedAction:
            delay(0) {
                feedService.updateFeed { updates in
                    dispatch?(FeedAction.EndRefreshFeed)
                    if let updates = updates {
                        dispatch?(FeedAction.MassItemUpdate(updates))
                    }
                }
            }

        case .MassItemUpdate as FeedAction:
            guard let state = getState() as? AppState else { break }
            let existingUserIds = state.users.map { $0.id }
            let updateUsers = state.feedItems.map { $0.userId }
                .filter { !existingUserIds.contains($0) }
            dispatch?(UserAction.UpdateUsers(updateUsers))

        default: break
        }

        return result
        }}
    }
}
