import ReSwift
import ReactiveKit

class ObservableStore<State: StateType>: Store<State> {

    let observable: Observable<State>

    override var state: State! {
        didSet {
            observable.value = state
        }
    }

    required init(reducer: AnyReducer, state: State, middleware: [Middleware]) {
        observable = Observable(state)
        super.init(reducer: reducer, state: state, middleware: middleware)
    }

    func map<U: Equatable>(selector: State -> U) -> Stream<U> {
        return observable.map(selector)
    }

    func dispatchAction(action: Action) {
        dispatch(action)
    }
}
