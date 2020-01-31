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

	private var authCoordinator: AuthCoordinator = AuthCoordinator.sharedInstance

	@IBOutlet weak var navigationBar: UINavigationBar!

	@IBAction func permissionButtonPressed(_ sender: Any) {
		authCoordinator.permissionsGiven = true

		presentNextVC()
	}

	@IBAction func cancelPressed(_ sender: Any) {
		authCoordinator.deauthorize()
		self.navigationController?.popToRootViewController(animated: true)
	}


	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		authCoordinator.currentScreen = self
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: #selector(self.navigationController?.popViewController(animated:))
		)
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
