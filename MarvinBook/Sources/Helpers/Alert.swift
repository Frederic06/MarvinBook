//
//  Alert.swift
//  MarvinBook
//
//  Created by Margarita Blanc on 20/06/2020.
//  Copyright © 2020 Frederic Blanc. All rights reserved.
//

import Foundation

enum AlertType: Equatable {
    case networkError, noValidEntry
}

struct Alert: Equatable {
    var title = "Alerte"
    let message: String
}

extension Alert {
    init(type: AlertType) {
        switch type {
        case .networkError:
            self = Alert(message: "A very very bad thing happened.. 🙈")
        case .noValidEntry:
            self = Alert(message: "Renseignez un mail et mot de passe valide svp 😡")
        }
    }
}
