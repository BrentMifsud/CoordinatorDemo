//
//  FirstViewController.swift
//  CoordinatorDemo
//
//  Created by Brent Mifsud on 2020-01-30.
//  Copyright © 2020 Brent Mifsud. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, Storyboarded, Coordinated {

	var coordinator: Coordinator?

	@IBOutlet weak var emailField: UITextField!
	@IBOutlet weak var passwordField: UITextField!

	@IBAction func nextButtonPressed(_ sender: Any) {
		guard let coordinator = coordinator as? MainCoordinator else {
			fatalError("Invalid Coordinator Type")
		}

		coordinator.userSocialGraphDTO.email = emailField.text ?? ""
		coordinator.userSocialGraphDTO.password = passwordField.text ?? ""

		debugPrint("EMAIL AND PASSWORD ENTERED: ########################")
		debugPrint("CURRENT SOCIAL GRAPH: \(coordinator.userSocialGraphDTO)")
		debugPrint("SOCIAL GRAPH AUTH WITH API: \(coordinator.socialGraphSent)")
		debugPrint("PERMISSION GRANTED: \(coordinator.permissionGranted)")
		debugPrint("CURRENT AUTH STATE: \(coordinator.authState)")
		debugPrint("####################################################")

		coordinator.nextView()
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		self.navigationController?.navigationBar.isHidden = false
		self.navigationController?
			.navigationBar
			.topItem?
			.rightBarButtonItem = UIBarButtonItem(
				title: "Cancel",
				style: .done,
				target: self,
				action: #selector(cancelPressed)
		)

		self.view.addGestureRecognizer(
			UITapGestureRecognizer(
				target: self,
				action: #selector(dismissKeyboard)
			)
		)
	}

	@objc func cancelPressed() {
		guard let coordinator = coordinator as? MainCoordinator else {
			fatalError("Invalid Coordinator Type")
		}

		coordinator.deauthorize()
	}

	@objc func dismissKeyboard() {
		self.emailField.resignFirstResponder()
		self.passwordField.resignFirstResponder()
	}
}
