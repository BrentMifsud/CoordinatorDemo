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

	private var authCoordinator: AuthCoordinator = AuthCoordinator.sharedInstance

	@IBAction func secondButtonPressed(_ sender: Any) {
		authCoordinator.secondScreenComplete = true
	}

	@IBAction func nextButtonPressed(_ sender: Any) {
		presentNextVC()
	}

	@IBAction func cancelPressed(_ sender: Any) {
		authCoordinator.deauthorize()
		self.navigationController?.popToRootViewController(animated: true)
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationController?.navigationBar.isHidden = false
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		authCoordinator.currentScreen = self
	}

	private func presentNextVC(){
		let nextVC = authCoordinator.nextView

		self.navigationController?.pushViewController(nextVC, animated: true)
	}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
