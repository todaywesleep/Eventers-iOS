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

enum AuthError: Equatable, Error {
    case unknown
    case custom(String)
    
    var localizedDescription: String {
        switch self {
        case .unknown:
            return "Unknown error while register"
        case let .custom(error):
            return error
        }
    }
}

enum AuthResponse: Equatable {
    case done
}

class AuthManager {
    private var cancellableStorage = Set<AnyCancellable>()
    
    var isAuthorized: Bool {
        Auth.auth().currentUser != nil
    }
    
    func register(password: String, userModel: UserModel) -> Future<AuthResponse, AuthError> {
        Future { promise in
            Auth.auth().createUser(withEmail: userModel.email, password: password) { (result, error) in
                self.handleAuthResponse(result: (result, error), handler: promise)
                
                apiManager.user.fillUserInfo(email: userModel.email, name: userModel.name, lastName: userModel.lastName, phone: userModel.phone)
                    .sink { response in
                        switch response {
                        case .done:
                            promise(.success(.done))
                        case let .error(text):
                            promise(.failure(.custom(text)))
                        }
                }.store(in: &self.cancellableStorage)
            }
        }
    }
    
    func authorize(using email: String, password: String) -> Future<AuthResponse, AuthError> {
        Future { promise in
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                guard let _ = result else {
                    self.handleAuthResponse(result: (result, error), handler: promise)
                    return
                }
                
                promise(.success(.done))
            }
        }
    }
    
    func logout() -> Future<AuthResponse, AuthError> {
        Future { promise in
            do {
               try Auth.auth().signOut()
                promise(.success(AuthResponse.done))
            } catch(let error) {
                promise(.failure(AuthError.custom(error.localizedDescription)))
            }
        }
    }
    
    private func handleAuthResponse(result: (AuthDataResult?, Error?), handler: (Result<AuthResponse, AuthError>) -> Void) {
        let response = result.0
        let error = result.1
        
        guard let _ = response else {
            error == nil
                ? handler(.failure(.custom("Unknown auth error")))
                : handler(.failure(.custom(error!.localizedDescription)))
            
            return
        }
    }
}
