//
//  AuthCoordinator.swift
//  CoordinatorDemo
//
//  Created by Brent Mifsud on 2020-01-30.
//  Copyright © 2020 Brent Mifsud. All rights reserved.
//

import UIKit

final class AuthCoordinator {

	static let sharedInstance: AuthCoordinator = AuthCoordinator()
	private let storyboard = UIStoryboard(name: "Main", bundle: nil)

	var currentScreen: UIViewController!

	var firstScreenComplete: Bool = false
	var secondScreenComplete: Bool = false
	var thirdScreenComplete: Bool = false
	var authScreensComplete: Bool = false
	var permissionsGiven: Bool = false

	private var authenticated: Bool {
		if firstScreenComplete &&
			secondScreenComplete &&
			thirdScreenComplete &&
			authScreensComplete {
			return true
		}
		return false
	}

	var state: AuthState {
		if authenticated && permissionsGiven {
			return .authenticatedWithPermission
		}

		if authenticated && !permissionsGiven {
			return .authenticatedNoPermission
		}

		if !authenticated && permissionsGiven {
			return .notAuthenticatedWithPermission
		}

		return .notAuthenticatedNoPermission
	}

	var nextView: UIViewController {
		switch state {
			case .notAuthenticatedNoPermission:
				return storyboard.instantiateViewController(
					withIdentifier: nextAuthViewIdentifier
			)
			case .authenticatedWithPermission:
				return storyboard.instantiateViewController(withIdentifier: "GoRideView")
			case .authenticatedNoPermission:
				return storyboard.instantiateViewController(withIdentifier: "PermissionView")
			case .notAuthenticatedWithPermission:
				return storyboard.instantiateViewController(
					withIdentifier: nextAuthViewIdentifier
			)
		}
	}

	private var nextAuthViewIdentifier: String {
		switch currentScreen {
			case currentScreen as LandingViewController:
				return "FirstView"
			case currentScreen as FirstViewController:
				return "SecondView"
			case currentScreen as SecondViewController:
				return "ThirdView"
			default:
				return "FirstView"
		}
	}

	private init() {}

	func deauthorize() {
		self.authScreensComplete = false
		self.firstScreenComplete = false
		self.secondScreenComplete = false
		self.thirdScreenComplete = false
		self.permissionsGiven = false
	}
}


