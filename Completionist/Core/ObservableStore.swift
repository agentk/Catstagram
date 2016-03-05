import ReSwift
import ReactiveKit

class ObservableStore<State: StateType>: Store<State> {

    let observable: Observable<State>

    required init(reducer: AnyReducer, state: State, middleware: [Middleware]) {
        observable = Observable(state)
        super.init(reducer: reducer, state: state, middleware: middleware)
    }

    override var state: State! {
        didSet {
            observable.value = state
        }
    }

    func map<U: Equatable>(selector: State -> U) -> Stream<U> {
        return observable.map(selector)
    }
}
