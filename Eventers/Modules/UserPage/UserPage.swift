//
//  UserPage.swift
//  Eventers
//
//  Created by Vladislav Erchik on 8/18/20.
//  Copyright © 2020 Vladislav Erchik. All rights reserved.
//

import Foundation
import ComposableArchitecture

struct UserPageState: Equatable {
    
}

enum UserPageAction: Equatable {
    case logout
    
    case handleLogout(Result<AuthResponse, AuthError>)
}

struct UserPageEnvironment {
    
}

let userPageReducer = Reducer<UserPageState, UserPageAction, UserPageEnvironment> { state, action, _ in
    switch action {
    case .logout:
        return apiManager.auth.logout()
            .catchToEffect()
            .map(UserPageAction.handleLogout)
        
    case let .handleLogout(result):
        switch result {
        case let .failure(error):
            break
        case let .success(response):
            mainNavigationStack.pop(to: .root)
            appNavigationStack.pop(to: .root)
        }
    }
    
    return .none
}
