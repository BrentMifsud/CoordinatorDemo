//
//  ThirdViewController.swift
//  CoordinatorDemo
//
//  Created by Brent Mifsud on 2020-01-30.
//  Copyright © 2020 Brent Mifsud. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, Storyboarded, Coordinated {

	var coordinator: Coordinator?

	@IBOutlet weak var usernameField: UITextField!

	@IBAction func completeButtonPressed(_ sender: Any) {
		guard let coordinator = coordinator as? MainCoordinator else {
			fatalError("Invalid Coordinator Type")
		}

		let username = usernameField.text ?? ""

		coordinator.userSocialGraphDTO.username = username
		coordinator.socialGraphSent = true

		debugPrint("COMPLETE BUTTON PRESSED IN THIRD: ######################")
		debugPrint(coordinator.userSocialGraphDTO)
		debugPrint(coordinator.socialGraphSent)
		debugPrint(coordinator.permissionGranted)
		debugPrint(coordinator.authState)
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
		self.usernameField.resignFirstResponder()
	}
}
