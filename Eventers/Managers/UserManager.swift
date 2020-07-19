//
//  UserManager.swift
//  Eventers
//
//  Created by Vladislav Erchik on 7/18/20.
//  Copyright © 2020 Vladislav Erchik. All rights reserved.
//

import Foundation
import Combine
import FirebaseFirestore

enum UserResponse {
    case done
    case error(String)
}

class UserManager {
    private var database: Firestore {
        Firestore.firestore()
    }
    
    func fillUserInfo(email: String, name: String, lastName: String, phone: String) -> Future<UserResponse, Never> {
        Future { promise in
            let model = UserModel(email: email, name: name, lastName: lastName, phone: phone)
            
            self.database.collection(Constants.Collections.user)
                .document(email)
                .setData(model.json) { error in
                    if let error = error {
                        promise(.success(.error(error.localizedDescription)))
                        return
                    }
                    
                    promise(.success(.done))
            }
        }
    }
}
