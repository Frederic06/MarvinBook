//
//  Screens.swift
//  MarvinBook
//
//  Created by Margarita Blanc on 20/06/2020.
//  Copyright © 2020 Frederic Blanc. All rights reserved.
//

import UIKit

final class Screens {
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: Screens.self))
}

// MARK: - Research

extension Screens {
    func createLoginViewController(delegate: LoginViewModelDelegate, logged: Bool) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let viewModel = LoginViewModel(delegate: delegate, logged: logged)
        viewController.viewModel = viewModel
        return viewController
    }
    
    func createHomeViewController(delegate: HomeViewModelDelegate, repoDelegate: RepositoryDelegate) -> UIViewController {
        let viewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        let route = Route()
        let network = HttpClient()
        let repository = MarvinBookRepository(networkClient: network, route: route, delegate: repoDelegate)
        let viewModel = HomeViewModel(delegate: delegate, repository: repository)
        viewController.viewModel = viewModel
        return viewController
    }
    
    func createDetailViewController(delegate: DetailViewModelDelegate, book: MarvinBook, books: [MarvinBook], repoDelegate: RepositoryDelegate) -> UIViewController {
        let route = Route()
        let network = HttpClient()
        let repository = MarvinBookRepository(networkClient: network, route: route, delegate: repoDelegate)
        let viewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        let viewModel = DetailViewModel(delegate: delegate, book: book, books: books, repository: repository)
        viewController.viewModel = viewModel
        return viewController
    }
}

// Alerts

extension Screens {
    func createAlert(for type: AlertType) -> UIAlertController {
        let alert = Alert(type: type)
        let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(action)
        return alertController
    }
}
