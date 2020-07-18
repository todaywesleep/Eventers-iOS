//
//  AuthManager.swift
//  Eventers
//
//  Created by Vladislav Erchik on 7/17/20.
//  Copyright © 2020 Vladislav Erchik. All rights reserved.
//

import Foundation
import FirebaseAuth
import Combine

enum RegistrationError: Equatable {
    case registrationUnknown
    case custom(String)
    
    var localizedDescription: String {
        switch self {
        case .registrationUnknown:
            return "Unknown error while register"
        case let .custom(error):
            return error
        }
    }
}

enum AuthResponse: Equatable {
    case success
    case error(String)
}

class AuthManager {
    func register(using email: String, password: String) -> Future<AuthResponse, Never> {
        Future { promise in
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                self.handleAuthResponse(result: (result, error), handler: promise)
            }
        }
    }
    
    func authorize(using email: String, password: String) -> Future<AuthResponse, Never> {
        Future { promise in
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                self.handleAuthResponse(result: (result, error), handler: promise)
            }
        }
    }
    
    private func handleAuthResponse(result: (AuthDataResult?, Error?), handler: (Result<AuthResponse, Never>) -> Void) {
        let response = result.0
        let error = result.1
        
        guard let _ = response else {
            error == nil
                ? handler(.success(.error("Unknown error")))
                : handler(.success(.error(error!.localizedDescription)))
            
            return
        }
        
        handler(.success(.success))
    }
}
