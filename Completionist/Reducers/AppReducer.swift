import ReSwift

struct AppReducer: Reducer {

    func handleAction(action: Action, state: AppState?) -> AppState {

        var state = state ?? AppState()

        switch action {
        case .Set(let route) as RouteAction:
            state.route = route
        default: break
        }

        return state
    }
}
