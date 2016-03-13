import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator!
    var feedService: FeedProviderService!

    func application(application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        // Setup and initialise services
        feedService = StaticFeedService()

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
        let state = coordinator != nil ? coordinator.store.state : AppState()
        coordinator = nil

        // Create a new coordinator and present
        coordinator = AppCoordinator(
            state: state,
            feedService: feedService)
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
