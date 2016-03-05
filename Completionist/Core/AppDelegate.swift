//
//  AppDelegate.swift
//  completionist
//
//  Created by Karl Bowden on 23/02/2016.
//  Copyright © 2016 Featherweight Labs. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator!


    func application(application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.

        coordinator = AppCoordinator()
        window = UIWindow(rootViewController: coordinator.viewController)
        window?.makeKeyAndVisible()

        return true
    }
}
