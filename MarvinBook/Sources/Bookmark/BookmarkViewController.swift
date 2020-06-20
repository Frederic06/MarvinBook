//
//  BookmarkViewController.swift
//  MarvinBook
//
//  Created by Margarita Blanc on 20/06/2020.
//  Copyright © 2020 Frederic Blanc. All rights reserved.
//

import UIKit

class BookMarkViewController: UIViewController {
    
    var viewModel: BookMarkViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bind(to: viewModel)
        viewModel.viewDidAppear()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func bind(to viewModel: BookMarkViewModel) {
        
    }
    
    
    
}

