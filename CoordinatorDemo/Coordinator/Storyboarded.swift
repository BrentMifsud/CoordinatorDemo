//
//  Storyboarded.swift
//  CoordinatorDemo
//
//  Created by Brent Mifsud on 2020-01-30.
//  Copyright © 2020 Brent Mifsud. All rights reserved.
//

import UIKit

protocol Storyboarded {
	static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
	static func instantiate() -> Self {
		let className = String(describing: self)
		let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)

		return storyboard.instantiateViewController(withIdentifier: className) as! Self
	}
}
