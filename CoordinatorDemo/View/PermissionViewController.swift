//
//  PermissionViewController.swift
//  CoordinatorDemo
//
//  Created by Brent Mifsud on 2020-01-30.
//  Copyright © 2020 Brent Mifsud. All rights reserved.
//

import UIKit

class PermissionViewController: UIViewController, Storyboarded, Coordinated {

	var coordinator: Coordinator?

	@IBOutlet weak var usernameField: UITextField!

	@IBAction func nextButtonPressed(_ sender: Any) {
		guard let coordinator = coordinator as? MainCoordinator else {
			fatalError("Invalid Coordinator Type")
		}

		coordinator.permissionGranted = true

		debugPrint("PERMISSION BUTTON PRESSED: #########################")
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
	}

	@objc func cancelPressed() {
		guard let coordinator = coordinator as? MainCoordinator else {
			fatalError("Invalid Coordinator Type")
		}

		coordinator.deauthorize()
	}
}
