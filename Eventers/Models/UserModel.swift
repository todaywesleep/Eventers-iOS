//
//  UserModel.swift
//  Eventers
//
//  Created by Vladislav Erchik on 7/18/20.
//  Copyright © 2020 Vladislav Erchik. All rights reserved.
//

import Foundation

struct UserModel: Codable, Equatable {
    var email: String
    var name: String
    var lastName: String
    var phone: String
    
    var json: [String: Any] {
        (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self), options: .allowFragments) as? [String: Any]) ?? [:]
    }
}
