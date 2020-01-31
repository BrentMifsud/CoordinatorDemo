//
//  MainCoordinator.swift
//  CoordinatorDemo
//
//  Created by Brent Mifsud on 2020-01-30.
//  Copyright © 2020 Brent Mifsud. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {

	//
	// MARK: - Class Properties
	//

	var userSocialGraphDTO: UserSocialGraphDTO = UserSocialGraphDTO()
	var socialGraphSent: Bool = false
	var permissionGranted: Bool = false
	var currentViewController: UIViewController? {
		return navigationController.topViewController
	}

	var authState: AuthState {
		if socialGraphSent && permissionGranted {
			return .authenticatedWithPermission
		}

		if socialGraphSent && !permissionGranted {
			return .authenticatedNoPermission
		}

		if !socialGraphSent && permissionGranted {
			return .notAuthenticatedWithPermission
		}

		return .notAuthenticatedNoPermission
	}


	//
	// MARK: - Implementation
	//

	var childCoordinators: [Coordinator] = []

	var navigationController: UINavigationController

	init(navigationController: UINavigationController) {
		self.navigationController = navigationController
	}

	func start() {
		let landingVC = LandingViewController.instantiate()
		landingVC.coordinator = self
		navigationController.pushViewController(landingVC, animated: false)
	}


	//
	// MARK: - Helper Methods
	//

	func nextView() {
		guard let currentVC = self.currentViewController else {
			fatalError("Invalid current view controller.")
		}

		if currentVC is LandingViewController || currentVC is PermissionViewController {
			switch authState {
				case .notAuthenticatedNoPermission,
					 .notAuthenticatedWithPermission:
					var nextVC = getNextSignUpView() as! UIViewController & Coordinated
					nextVC.coordinator = self
					navigationController.pushViewController(nextVC, animated: true)
				case .authenticatedWithPermission:
					let nextVC = GoRideViewController.instantiate()
					nextVC.coordinator = self
					navigationController.pushViewController(nextVC, animated: true)
				case .authenticatedNoPermission:
					let nextVC = PermissionViewController.instantiate()
					nextVC.coordinator = self
					navigationController.pushViewController(nextVC, animated: true)
			}
		} else {
			var nextVC = getNextSignUpView() as! UIViewController & Coordinated
			nextVC.coordinator = self
			navigationController.pushViewController(nextVC, animated: true)
		}
	}

	func deauthorize() {
		self.userSocialGraphDTO = UserSocialGraphDTO()
		self.socialGraphSent = false
		self.permissionGranted = false
		self.navigationController.popToRootViewController(animated: true)

		debugPrint("DEAUTHORIZING USER: ################################")
		debugPrint("CURRENT SOCIAL GRAPH: \(self.userSocialGraphDTO)")
		debugPrint("SOCIAL GRAPH AUTH WITH API: \(self.socialGraphSent)")
		debugPrint("PERMISSION GRANTED: \(self.permissionGranted)")
		debugPrint("CURRENT AUTH STATE: \(self.authState)")
		debugPrint("####################################################")
	}

	private func getNextSignUpView() -> UIViewController {
		guard let currentVC = self.currentViewController else {
			fatalError("Invalid current view controller.")
		}

		if let _ = currentVC as? LandingViewController {
			return FirstViewController.instantiate()
		} else if let _ = currentVC as? FirstViewController {
			return SecondViewController.instantiate()
		} else if let _ = currentVC as? SecondViewController {
			return ThirdViewController.instantiate()
		} else if let _ = currentVC as? ThirdViewController {
			if !permissionGranted {
				return PermissionViewController.instantiate()
			} else {
				return GoRideViewController.instantiate()
			}
		}

		fatalError("Should never reach this point")
	}

	enum AuthState {
		case authenticatedWithPermission
		case authenticatedNoPermission
		case notAuthenticatedWithPermission
		case notAuthenticatedNoPermission
	}

}
