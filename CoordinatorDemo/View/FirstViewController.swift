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

		coordinator.nextView()
	}

	@IBAction func cancelPressed(_ sender: Any) {
		guard let coordinator = coordinator as? MainCoordinator else {
			fatalError("Invalid Coordinator Type")
		}

		coordinator.deauthorize()
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		self.view.addGestureRecognizer(
			UITapGestureRecognizer(
				target: self,
				action: #selector(dismissKeyboard)
			)
		)
	}

	@objc func dismissKeyboard() {
		self.emailField.resignFirstResponder()
		self.passwordField.resignFirstResponder()
	}
}
