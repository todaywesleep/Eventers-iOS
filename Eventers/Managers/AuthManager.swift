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
    case done
    case error(String)
}

class AuthManager {
    private var authCancellables = Set<AnyCancellable>()
    
    func register(password: String, userModel: UserModel) -> Future<AuthResponse, Never> {
        Future { promise in
            Auth.auth().createUser(withEmail: userModel.email, password: password) { (result, error) in
                self.handleAuthResponse(result: (result, error), handler: promise)
                
                UserManager().fillUserInfo(email: userModel.email, name: userModel.name, lastName: userModel.lastName, phone: userModel.phone)
                    .sink { response in
                        switch response {
                        case .done:
                            promise(.success(.done))
                        case let .error(text):
                            promise(.success(.error(text)))
                        }
                    }.store(in: &self.authCancellables)
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
    }
}
