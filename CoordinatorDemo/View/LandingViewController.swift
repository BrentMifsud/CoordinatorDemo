//
//  ViewController.swift
//  CoordinatorDemo
//
//  Created by Brent Mifsud on 2020-01-30.
//  Copyright © 2020 Brent Mifsud. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController, Storyboarded, Coordinated {

	private let authCoordinator = AuthCoordinator.sharedInstance

	var coordinator: Coordinator?

	@IBOutlet weak var navigationBar: UINavigationItem!

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

		coordinator.socialGraphSent = true
		coordinator.permissionGranted = true

		coordinator.nextView()
	}

	@IBAction func signUpPressed(_ sender: Any) {
		guard let coordinator = coordinator as? MainCoordinator else {
			fatalError("Cannot access Main Coordinator")
		}

		coordinator.userSocialGraphDTO = UserSocialGraphDTO()
		coordinator.permissionGranted = false

		coordinator.nextView()
	}

	@IBAction func noPermissionsPressed(_ sender: Any) {
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
		
		coordinator.nextView()
	}

	@IBAction func permissionsNoAuthPressed(_ sender: Any) {
		guard let coordinator = coordinator as? MainCoordinator else {
			fatalError("Cannot access Main Coordinator")
		}

		coordinator.userSocialGraphDTO = UserSocialGraphDTO()
		coordinator.socialGraphSent = false
		coordinator.permissionGranted = true

		coordinator.nextView()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(false)

		self.navigationController?.navigationBar.isHidden = true
	}
}

