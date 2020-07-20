//
//  ApiManager.swift
//  Eventers
//
//  Created by Vladislav Erchik on 7/21/20.
//  Copyright © 2020 Vladislav Erchik. All rights reserved.
//

import Foundation

protocol ApiManagerService {
    var auth: AuthManager { get }
    var user: UserManager { get }
}

class ApiManager: ApiManagerService {
    let auth: AuthManager
    let user: UserManager
    
    init(authManager: AuthManager, userManager: UserManager) {
        self.auth = authManager
        self.user = userManager
    }
}
