//
//  GoRideViewController.swift
//  CoordinatorDemo
//
//  Created by Brent Mifsud on 2020-01-30.
//  Copyright © 2020 Brent Mifsud. All rights reserved.
//

import UIKit

class GoRideViewController: UIViewController, Storyboarded, Coordinated {
	
	var coordinator: Coordinator?

	@IBAction func logoutPressed(_ sender: UIBarButtonItem) {
		guard let coordinator = coordinator as? MainCoordinator else {
			fatalError("Invalid Coordinator")
		}
		coordinator.deauthorize()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		self.navigationController?.navigationBar.isHidden = true

		guard let coordinator = coordinator as? MainCoordinator else {
			fatalError("Invalid Coordinator")
		}

		debugPrint("GORIDE SCREEN APPEARED: ###########################")
		debugPrint("CURRENT SOCIAL GRAPH: \(coordinator.userSocialGraphDTO)")
		debugPrint("SOCIAL GRAPH AUTH WITH API: \(coordinator.socialGraphSent)")
		debugPrint("PERMISSION GRANTED: \(coordinator.permissionGranted)")
		debugPrint("CURRENT AUTH STATE: \(coordinator.authState)")
		debugPrint("####################################################")
	}
}
