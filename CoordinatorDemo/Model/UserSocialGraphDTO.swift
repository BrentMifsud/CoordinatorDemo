//
//  UserSocialGraphDTO.swift
//  CoordinatorDemo
//
//  Created by Brent Mifsud on 2020-01-30.
//  Copyright © 2020 Brent Mifsud. All rights reserved.
//

struct UserSocialGraphDTO: Codable {
	var firstName: String = ""
	var lastName: String = ""
	var realName: String = ""
	var email: String = ""
	var username: String = ""
	var password: String = ""

	var socialGraphState: SocialGraphState {
		if !firstName.isEmpty
			&& !lastName.isEmpty
			&&	!realName.isEmpty
			&& !email.isEmpty
			&& !username.isEmpty
			&& !password.isEmpty {
			return .empty
		}

		/*
		realName implies first and last name are populated.
		Email and username are required fields.
		Password is ESR only.
		*/
		if !realName.isEmpty && !email.isEmpty && !username.isEmpty {
			return .completeAuthProvider
		}

		if !realName.isEmpty
			&& !email.isEmpty
			&& !username.isEmpty
			&& !password.isEmpty {
			return .completeESR
		}

		return .incomplete
	}
}

enum SocialGraphState {
	case empty
	case completeAuthProvider
	case completeESR
	case incomplete
}
