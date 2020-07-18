//
//  BaseAuthState.swift
//  Eventers
//
//  Created by Vladislav Erchik on 7/18/20.
//  Copyright © 2020 Vladislav Erchik. All rights reserved.
//

import Foundation

protocol BaseAuthState: Equatable {
    var email: String { get set }
    var password: String { get set }
    var isLoading: Bool { get set }
}
