import Foundation
import ReSwift

let makeUserMiddleware: FeedProviderService -> Middleware = { feedService in {
    dispatch, getState in { next in { action in

        let result = next(action)

        switch action {
        case .UpdateUsers(let userIds) as UserAction:
            delay(0) {
                for userId in userIds {
                    feedService.getUser(userId) { user in
                        guard let user = user else { return }
                        print(user)
                        delay(0.1 * Double(arc4random_uniform(10))) {
                            dispatch?(UserAction.MassUpdateUsers([user]))
                        }
                    }
                }
            }

        default: break
        }

        return result
        }}
    }
}
