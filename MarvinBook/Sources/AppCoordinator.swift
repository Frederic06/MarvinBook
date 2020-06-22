//
//  AppCoordinator.swift
//  MarvinBook
//
//  Created by Margarita Blanc on 20/06/2020.
//  Copyright © 2020 Frederic Blanc. All rights reserved.
//

import UIKit
import CoreData

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
    
// MARK: -Private methods
    private func showLogin() {
        let logged: Bool = UserDefaults.standard.bool(forKey: "Logged")
        let vc = screens.createLoginViewController(delegate: self, logged: (logged == true) ? true : false)
        navigator.viewControllers = [vc]
    }
    
    private func showHome() {
        let vc = screens.createHomeViewController(delegate: self, repoDelegate: self)
        navigator.pushViewController(vc, animated: true)
    }
    
    private func showDetail(book: MarvinBook, books: [MarvinBook]) {
        let vc = screens.createDetailViewController(delegate: self, book: book, books: books, repoDelegate: self)
        navigator.pushViewController(vc, animated: true)
    }
    
    private func fetch(bookId: String) {
        let request: NSFetchRequest<BookItem> = BookItem.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", bookId)
    }
}

// Conforming to LoginViewModelDelegate Protocol
extension AppCoordinator: LoginViewModelDelegate {
    func presentAlert(type: AlertType) {
        let alert = screens.createAlert(for: type)
        navigator.visibleViewController?.present(alert, animated: true, completion: nil)
    }
    
    func loggedIn() {
        showHome()
        UserDefaults.standard.set(true, forKey: "Logged")
    }
}

// Conforming to HomeViewModelDelegate Protocol
extension AppCoordinator: HomeViewModelDelegate {
    
    func displayDetail(book: MarvinBook, books: [MarvinBook]) {
        showDetail(book: book, books: books)
    }
    
    func loggedOut() {
        UserDefaults.standard.set(false, forKey: "Logged")
        navigator.popViewController(animated: true)
        navigator.popViewController(animated: true)
        start()
    }
}

// Conforming to DetailViewModelDelegate Protocol
extension AppCoordinator: DetailViewModelDelegate {
    
    func dismissDetail() {
        navigator.popViewController(animated: true)
    }
    
    func displayOther(book: MarvinBook?, books: [MarvinBook]) {
        navigator.popViewController(animated: true)
        guard let book = book else {return}
        showDetail(book: book, books: books)
    }
}

extension AppCoordinator: RepositoryDelegate{
    func error() {
        let alert = screens.createAlert(for: .networkError)
        navigator.visibleViewController?.present(alert, animated: true, completion: nil)
    }
}
