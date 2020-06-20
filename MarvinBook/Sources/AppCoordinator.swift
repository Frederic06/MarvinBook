//
//  AppCoordinator.swift
//  MarvinBook
//
//  Created by Margarita Blanc on 20/06/2020.
//  Copyright © 2020 Frederic Blanc. All rights reserved.
//

import UIKit

final class AppCoordinator {
    
    // MARK: - Private properties
    
    private var presenter: UIWindow
    
    private var navigator = UINavigationController()
    
    private var screens = Screens()
    
    private let container = UserDefaults.standard
    
    // MARK: - Initializer
    
    init(presenter: UIWindow) {
        self.presenter = presenter
    }
    
    // MARK: - Coordinator
    func start() {
        presenter.rootViewController = navigator
        
        if ProcessInfo.processInfo.environment["IS_RUNNING_UNIT_TESTS"] == "YES" {
            return
        }
        
        showLogin()
    }
    
    private func showLogin() {
        
        let logged: Bool = UserDefaults.standard.bool(forKey: "Logged")
        
        let vc = screens.createLoginViewController(delegate: self, logged: (logged == true) ? true : false)
        navigator.viewControllers = [vc]
//        navigator.pushViewController(vc, animated: true)
    }
    
    private func showHome() {
        
        let vc = screens.createHomeViewController(delegate: self)
        navigator.pushViewController(vc, animated: true)
    }
}

extension AppCoordinator: LoginViewModelDelegate {
    func presentAlert(type: AlertType) {
        
        let alert = screens.createAlert(for: type)
        navigator.visibleViewController?.present(alert, animated: true, completion: nil)
    }
    
    func loggedIn() {
        showHome()
//        UserDefaults.standard.set(true, forKey: "Logged")
    }
    
    
}

extension AppCoordinator: HomeViewModelDelegate {
    func loggedOut() {
        UserDefaults.standard.set(false, forKey: "Logged")
        navigator.popViewController(animated: true)
        navigator.popViewController(animated: true)
        start()
    }
}



