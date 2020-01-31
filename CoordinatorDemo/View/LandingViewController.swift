//
//  ViewController.swift
//  CoordinatorDemo
//
//  Created by Brent Mifsud on 2020-01-30.
//  Copyright © 2020 Brent Mifsud. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController, Storyboarded, Coordinated {

	var coordinator: Coordinator?


	/// User is signing up from scratch.
	@IBAction func signUpPressed(_ sender: Any) {
		guard let coordinator = coordinator as? MainCoordinator else {
			fatalError("Cannot access Main Coordinator")
		}

		coordinator.userSocialGraphDTO = UserSocialGraphDTO()
		coordinator.permissionGranted = false

		debugPrint("FRESH SIGN-UP: #####################################")
		debugPrint("CURRENT SOCIAL GRAPH: \(coordinator.userSocialGraphDTO)")
		debugPrint("SOCIAL GRAPH AUTH WITH API: \(coordinator.socialGraphSent)")
		debugPrint("PERMISSION GRANTED: \(coordinator.permissionGranted)")
		debugPrint("CURRENT AUTH STATE: \(coordinator.authState)")
		debugPrint("####################################################")

		coordinator.nextView()
	}

	/// User is valid and is logging in. Permissions were granted previously.
	@IBAction func loginButtonPressed(_ sender: Any) {
		guard let coordinator = coordinator as? MainCoordinator else {
			fatalError("Could not find main coordinator")
		}

		coordinator.userSocialGraphDTO = UserSocialGraphDTO(
			firstName: "Joe",
			lastName: "Test",
			realName: "Joe Test",
			email: "joe.test@gmail.com",
			username: "JoeTest1234",
			password: "testpassword"
		)

		debugPrint("LOGIN WITH PERMISSIONS: ############################")
		debugPrint("CURRENT SOCIAL GRAPH: \(coordinator.userSocialGraphDTO)")
		debugPrint("SOCIAL GRAPH AUTH WITH API: \(coordinator.socialGraphSent)")
		debugPrint("PERMISSION GRANTED: \(coordinator.permissionGranted)")
		debugPrint("CURRENT AUTH STATE: \(coordinator.authState)")
		debugPrint("####################################################")

		coordinator.socialGraphSent = true
		coordinator.permissionGranted = true

		coordinator.nextView()
	}

	/// User reinstalled app and is logging in without permissions.
	@IBAction func loginWithoutPermission(_ sender: Any) {
		guard let coordinator = coordinator as? MainCoordinator else {
			fatalError("Cannot access Main Coordinator")
		}

		coordinator.userSocialGraphDTO = UserSocialGraphDTO(
			firstName: "Joe",
			lastName: "Test",
			realName: "Joe Test",
			email: "joe.test@gmail.com",
			username: "JoeTest1234",
			password: "testpassword"
		)

		coordinator.socialGraphSent = true
		coordinator.permissionGranted = false

		debugPrint("LOGIN WITHOUT PERMISSIONS: #########################")
		debugPrint("CURRENT SOCIAL GRAPH: \(coordinator.userSocialGraphDTO)")
		debugPrint("SOCIAL GRAPH AUTH WITH API: \(coordinator.socialGraphSent)")
		debugPrint("PERMISSION GRANTED: \(coordinator.permissionGranted)")
		debugPrint("CURRENT AUTH STATE: \(coordinator.authState)")
		debugPrint("####################################################")
		
		coordinator.nextView()
	}

	/// User has downloaded app for the first time and granted themself permissions from settings.
	@IBAction func signUpWithPermission(_ sender: Any) {
		guard let coordinator = coordinator as? MainCoordinator else {
			fatalError("Cannot access Main Coordinator")
		}

		coordinator.userSocialGraphDTO = UserSocialGraphDTO()
		coordinator.socialGraphSent = false
		coordinator.permissionGranted = true

		debugPrint("SIGN-UP WITH PERMISSIONS: ##########################")
		debugPrint("CURRENT SOCIAL GRAPH: \(coordinator.userSocialGraphDTO)")
		debugPrint("SOCIAL GRAPH AUTH WITH API: \(coordinator.socialGraphSent)")
		debugPrint("PERMISSION GRANTED: \(coordinator.permissionGranted)")
		debugPrint("CURRENT AUTH STATE: \(coordinator.authState)")
		debugPrint("####################################################")

		coordinator.nextView()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(false)

		self.navigationController?.navigationBar.isHidden = true

		guard let coordinator = coordinator as? MainCoordinator else {
			fatalError("Invalid Coordinator")
		}

		debugPrint("LANDING SCREEN APPEARED: ###########################")
		debugPrint("CURRENT SOCIAL GRAPH: \(coordinator.userSocialGraphDTO)")
		debugPrint("SOCIAL GRAPH AUTH WITH API: \(coordinator.socialGraphSent)")
		debugPrint("PERMISSION GRANTED: \(coordinator.permissionGranted)")
		debugPrint("CURRENT AUTH STATE: \(coordinator.authState)")
		debugPrint("####################################################")
	}
}

