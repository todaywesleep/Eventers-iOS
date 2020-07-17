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

enum RegistrationResponse: Equatable {
    case registered
    case error(RegistrationError)
}

class AuthManager {
    func register(using email: String, password: String) -> Future<RegistrationResponse, Never> {
        Future { promise in
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                guard let _ = result else {
                    error == nil
                        ? promise(.success(.error(.registrationUnknown)))
                        : promise(.success(.error(.custom(error!.localizedDescription))))
                    
                    return
                }
                
                promise(.success(.registered))
            }
        }
    }
}
