import ReSwift

struct AppReducer: Reducer {

    func handleAction(action: Action, state: AppState?) -> AppState {

        var state = state ?? AppState()

        switch action {
        case .Set(let route) as RouteAction:
            state.route = route
        default: break
        }

        state.users = userReducer(action, users: state.users)

        return feedListReducer(action, state: state)
    }
}
