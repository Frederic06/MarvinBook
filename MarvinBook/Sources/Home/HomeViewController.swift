//
//  HomeViewController.swift
//  MarvinBook
//
//  Created by Margarita Blanc on 20/06/2020.
//  Copyright © 2020 Frederic Blanc. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
// MARK: -Public properties
    var viewModel: HomeViewModel!
    
// MARK: -Private properties
    private var collectionDataSource: BookCollectionDataSource!
    private var bookTableDataSource: BookTableDataSource!
    private var favoriteBooksTableDataSource: FavoriteBooksTable!
    
// MARK: -IBOutlets
    @IBOutlet weak var globalBookView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bookCollection: UICollectionView!
    @IBOutlet weak var bookTable: UITableView!
    @IBOutlet weak var favTableView: UITableView!
    @IBOutlet weak var bottomButtonView: CurvedView!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var favoriteImage: UIImageView!
    
// MARK: -View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        collectionDataSource = BookCollectionDataSource(collection: bookCollection)
        bookTableDataSource = BookTableDataSource(tableView: bookTable)
        favoriteBooksTableDataSource = FavoriteBooksTable(tableView: favTableView)
        
        bind(to: viewModel)
        bind(to: collectionDataSource)
        bind(to: bookTableDataSource)
        bind(to: favoriteBooksTableDataSource)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        viewModel.viewDidAppear()
    }
    
// MARK: -Private methods
    private func bind(to viewModel: HomeViewModel) {
        
        viewModel.attributedTitle = { [weak self] title in
            self?.titleLabel.attributedText = title
        }
        
        viewModel.booksToDisplay = { [weak self] books in
            DispatchQueue.main.async {
                self?.collectionDataSource.updateCells(books: books)
                self?.bookTableDataSource.update(array: books)
            }
        }
        
        viewModel.favTableViewHidden = { [weak self] status in
            DispatchQueue.main.async {
            self?.favTableView.isHidden = status
            }
        }
        
        viewModel.globalBookViewHidden = { [weak self] status in
            DispatchQueue.main.async {
            self?.globalBookView.isHidden = status
            }
        }
        
        viewModel.buttonFavSelected = { [weak self] status in
            DispatchQueue.main.async {
            self?.bookImage.tintColor = (status == true) ? #colorLiteral(red: 0.4010359645, green: 0.3956674337, blue: 0.4174249172, alpha: 1) : .white
            self?.favoriteImage.tintColor = (status == true) ? .white : #colorLiteral(red: 0.4010359645, green: 0.3956674337, blue: 0.4174249172, alpha: 1)
            }
        }
        
        viewModel.tableViewHidden = { [weak self] bool in
            DispatchQueue.main.async {
                self?.bookTable.isHidden = (bool == true) ? true : false
            }
        }
        viewModel.savedBooks = { [weak self] books in
            DispatchQueue.main.async {
                self?.favoriteBooksTableDataSource.update(array: books)
            }
        }
    }
    
    private func bind(to dataSource: FavoriteBooksTable) {
        dataSource.open = viewModel.display
    }
    
    private func bind(to dataSource: BookCollectionDataSource) {
        dataSource.didSelectEvent = viewModel.display
    }
    
    private func bind(to dataSource: BookTableDataSource) {
        dataSource.open = viewModel.display
    }
    
    private func setUI() {
        bookTable.isHidden = true
        self.view.bringSubviewToFront(bottomButtonView)
        bookImage.isUserInteractionEnabled = true
        favoriteImage.isUserInteractionEnabled = true
    }
    
// MARK: - IBActions
    @IBAction func logOut(_ sender: UIButton) {
        viewModel.logOut()
    }
    
    @IBAction func tappedOnBooks(_ sender: Any) {
        viewModel.pressedSeeBooks()
    }
    
    @IBAction func tappedOnFavorites(_ sender: Any) {
        viewModel.pressedSeeFavorite()
    }
}
