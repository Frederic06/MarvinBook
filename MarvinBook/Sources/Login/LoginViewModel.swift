//
//  LoginViewModel.swift
//  MarvinBook
//
//  Created by Margarita Blanc on 20/06/2020.
//  Copyright © 2020 Frederic Blanc. All rights reserved.
//

import Foundation

protocol LoginViewModelDelegate {
    func loggedIn()
    func presentAlert(type: AlertType)
}

final class LoginViewModel {
    
    // MARK: -Private properties
    private let delegate: LoginViewModelDelegate
    private let isLoggedIn: Bool
    private var timer = Timer()
    
    // MARK: -Public properties
    var attributedTitle: ((NSAttributedString) -> Void)?
    var activityIndicatorHidden: ((Bool) -> Void)?
    var loginViewHidden: ((Bool) -> Void)?
    var mailPlaceHolderHidden: ((Bool) -> Void)?
    var passwordPlaceHolderHidden: ((Bool) -> Void)?
    
    // MARK: -Init
    init(delegate: LoginViewModelDelegate, logged: Bool) {
        self.delegate = delegate
        self.isLoggedIn = logged
    }
    
    // MARK: -Public Methods
    func viewDidAppear() {
        let titleAttributed = setHalfBold(normalText: "Marvin", boldText: "Book", fontSize: 35)
        attributedTitle?(titleAttributed)
        switch isLoggedIn {
        case true:
            logIn()
        default:
            activityIndicatorHidden?(true)
            break
        }
    }
    
    func connexionTapped(mail: String, password: String) {
        logIn()
    }
    
    func noValidMailOrPassword() {
        delegate.presentAlert(type: .noValidEntry)
    }
    
    func mailTextFieldChanged() {
        mailPlaceHolderHidden?(true)
    }
    
    func passwordTextFieldChanged() {
        passwordPlaceHolderHidden?(true)
    }
    
    // MARK: -Private methods
    private func logIn() {
        loginViewHidden?(true)
        activityIndicatorHidden?(false)
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (nil) in
            self.delegate.loggedIn()
        }
    }
}
