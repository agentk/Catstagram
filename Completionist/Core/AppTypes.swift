import UIKit
import FeatherweightRouter
import ReSwift
import ReactiveKit

typealias AppStore = ObservableStore<AppState>
typealias ObservableState = Observable<AppState>

typealias UIRouter = Router<UIViewController>
typealias UIPresenter = RouterDelegate<UIViewController>
