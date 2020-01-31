//
//  SecondViewController.swift
//  CoordinatorDemo
//
//  Created by Brent Mifsud on 2020-01-30.
//  Copyright © 2020 Brent Mifsud. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, Storyboarded, Coordinated {

	var coordinator: Coordinator?

	@IBOutlet weak var firstNameField: UITextField!
	@IBOutlet weak var lastNameField: UITextField!

	@IBAction func nextButtonPressed(_ sender: Any) {
		guard let coordinator = coordinator as? MainCoordinator else {
			fatalError("Invalid Coordinator Type")
		}

		let firstName = firstNameField.text ?? ""
		let lastName = lastNameField.text ?? ""
		let realName = "\(firstName) \(lastName)"
			.trimmingCharacters(in: .whitespacesAndNewlines)

		coordinator.userSocialGraphDTO.firstName = firstName
		coordinator.userSocialGraphDTO.lastName = lastName
		coordinator.userSocialGraphDTO.realName = realName

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
		self.firstNameField.resignFirstResponder()
		self.lastNameField.resignFirstResponder()
	}

}
