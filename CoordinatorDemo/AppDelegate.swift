//
//  AppDelegate.swift
//  CoordinatorDemo
//
//  Created by Brent Mifsud on 2020-01-30.
//  Copyright © 2020 Brent Mifsud. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var coordinator: MainCoordinator?

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.

		let navController = UINavigationController()

		coordinator = MainCoordinator(navigationController: navController)

		coordinator?.start()

		window = UIWindow(frame: UIScreen.main.bounds)
		window?.rootViewController = navController
		window?.makeKeyAndVisible()

		return true
	}
}

