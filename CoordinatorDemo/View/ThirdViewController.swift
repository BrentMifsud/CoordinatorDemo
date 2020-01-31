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

	@IBOutlet weak var navigationBar: UINavigationBar!

	private var authCoordinator: AuthCoordinator = AuthCoordinator.sharedInstance

	@IBAction func thirdButtonPressed(_ sender: Any) {
		authCoordinator.thirdScreenComplete = true
	}

	@IBAction func completeSignInButtonPressed(_ sender: Any) {
		authCoordinator.authScreensComplete = true
		presentNextVC()
	}

	@IBAction func cancelPressed(_ sender: Any) {
		authCoordinator.deauthorize()
		self.navigationController?.popToRootViewController(animated: true)
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		self.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: #selector(self.navigationController?.popViewController(animated:))
		)
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		authCoordinator.currentScreen = self
	}

	private func presentNextVC(){
		let nextVC = authCoordinator.nextView

		self.navigationController?.pushViewController(nextVC, animated: true)
	}
}
