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
		}
	}

	func deauthorize() {
		self.userSocialGraphDTO = UserSocialGraphDTO()
		self.socialGraphSent = false
		self.permissionGranted = false
		self.navigationController.popToRootViewController(animated: true)
	}

	private func getNextSignUpView() -> UIViewController {
		guard let currentVC = self.currentViewController else {
			fatalError("Invalid current view controller.")
		}

		guard userSocialGraphDTO.socialGraphState != .completeESR
			&& userSocialGraphDTO.socialGraphState != .completeAuthProvider else {
				fatalError("Should never reach this point.")
		}

		if let _ = currentVC as? LandingViewController {
			return FirstViewController.instantiate()
		} else if let _ = currentVC as? FirstViewController {
			return SecondViewController.instantiate()
		} else {
			return ThirdViewController.instantiate()
		}
	}
}

enum AuthState {
	case authenticatedWithPermission
	case authenticatedNoPermission
	case notAuthenticatedWithPermission
	case notAuthenticatedNoPermission
}


