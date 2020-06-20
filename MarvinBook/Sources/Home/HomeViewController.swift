//
//  HomeViewController.swift
//  MarvinBook
//
//  Created by Margarita Blanc on 20/06/2020.
//  Copyright © 2020 Frederic Blanc. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
// MARK: -Properties
    
    var viewModel: HomeViewModel!
    
    private var collectionDataSource: BookCollectionDataSource!
    
// MARK: -IBOutlets
    
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var bookCollection: UICollectionView!
    
    @IBOutlet weak var bookTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionDataSource = BookCollectionDataSource(collection: bookCollection)

        bind(to: viewModel)
        viewModel.viewDidAppear()
    }
    
    private func bind(to viewModel: HomeViewModel) {
        
        viewModel.attributedTitle = { [weak self] title in
            self?.titleLabel.attributedText = title
            
        }
        
        viewModel.booksToDisplay = collectionDataSource.updateCells
    }
    
    private func bind(to dataSource: BookCollectionDataSource) {
        dataSource.didSelectEvent = viewModel.display
    }
    
// MARK: - IBActions

    @IBAction func logOut(_ sender: UIButton) {
        viewModel.logOut()
    }
    
}
