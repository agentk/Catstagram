import UIKit
import SocketIOClientSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator!
    var feedService: FeedProviderService!
    var devSocket: SocketIOClient!

    func application(application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        // Setup and initialise services
        feedService = StaticFeedService()

        // swiftlint:disable:next force_cast
        devSocket = SocketIOClient(socketURL: NSURL(string: "http://localhost:9000")!,
                                   options: [.ReconnectWait(1)])
        devSocket.on("connect") { _ in
            print("[TARDIS]: Connected")
            let deviceId = UIDevice.currentDevice().identifierForVendor?.UUIDString ?? "unknown"
            self.devSocket.emit("deviceId", deviceId)
        }
        devSocket.on("disconnect") { _ in print("[TARDIS]: DISCONNECTED") }
        devSocket.connect()

        // Create and present the initial coordinator
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        refreshCoordinator()
        window?.makeKeyAndVisible()

        #if DEBUG
            observeInjection()
        #endif

        return true
    }

    func refreshCoordinator() {
        // Save state and tear down
//        let state = coordinator != nil ? coordinator.store.state : AppState()
        let state = AppState()
        coordinator = nil

        // Create a new coordinator and present
        coordinator = AppCoordinator(
            state: state,
            feedService: feedService,
            socket: devSocket)
        window?.rootViewController = coordinator.viewController
    }

    #if DEBUG
    let injectionNotification = "INJECTION_BUNDLE_NOTIFICATION"

    func observeInjection() {
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(AppDelegate.interjected(_:)),
            name: injectionNotification,
            object: nil)
    }

    func interjected(notification: NSNotification) {
        guard notification.name == injectionNotification else { return }
        print(" ----- Injection 💉 complete ----- ")
        refreshCoordinator()
    }
    #endif
}
