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

	private let authCoordinator: AuthCoordinator = AuthCoordinator.sharedInstance

	@IBAction func logoutPressed(_ sender: Any) {
		authCoordinator.deauthorize()
		self.navigationController?.popToRootViewController(animated: true)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		authCoordinator.currentScreen = self
	}
}
