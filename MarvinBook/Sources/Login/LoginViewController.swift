//
//  ViewController.swift
//  MarvinBook
//
//  Created by Margarita Blanc on 20/06/2020.
//  Copyright © 2020 Frederic Blanc. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

//MARK: -Public Properties
    var viewModel: LoginViewModel!

//MARK: -IBOutlets
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emailPlaceHolder: UILabel!
    @IBOutlet weak var passwordPlaceHolder: UILabel!
    
// MARK: -ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
        viewModel.viewDidAppear()
        
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        
        setUI()
    }

//MARK: -Private methods
    private func bind(to viewModel: LoginViewModel) {
        
        viewModel.attributedTitle = { [weak self] title in
            self?.titleLabel.attributedText = title
        }
        
        viewModel.activityIndicatorHidden = { [weak self] status in
            self?.activityIndicator.isHidden = status
            self?.activityIndicator.startAnimating()
        }
        
        viewModel.loginViewHidden = { [weak self] status in
            self?.loginView.isHidden = status
        }
        
        viewModel.mailPlaceHolderHidden = { [weak self] status in
            self?.emailPlaceHolder.isHidden = status
        }
        
        viewModel.passwordPlaceHolderHidden = { [weak self] status in
            self?.passwordPlaceHolder.isHidden = status
        }
    }
    
    private func setUI() {
        self.navigationController?.navigationBar.isHidden = true
        self.emailTextField.placeholder = "email"
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange), for: .editingChanged)
    }

//MARK: -IB Actions
    @IBAction func connexionPressed(_ sender: Any) {
        guard emailTextField.text != "" else {viewModel.noValidMailOrPassword(); return}
        
        guard passwordTextField.text != "" else {viewModel.noValidMailOrPassword(); return}
        viewModel.connexionTapped(mail: emailTextField.text!, password: passwordTextField.text!)
    }
    
    @objc func textFieldDidChange() {
        viewModel.mailTextFieldChanged()
    }
    
    @objc func passwordTextFieldDidChange() {
        viewModel.passwordTextFieldChanged()
    }
}

//MARK: -Extensions
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
