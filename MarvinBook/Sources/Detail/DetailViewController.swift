//
//  DetailViewController.swift
//  MarvinBook
//
//  Created by Margarita Blanc on 20/06/2020.
//  Copyright © 2020 Frederic Blanc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: -Public propertie
    var viewModel: DetailViewModel!
    
    // MARK: -Private propertie
    private var bookDetailCollectionDataSource: BookDetailCollectionDataSource!
    
    // MARK: -IB Outlets
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var favoriteButtonView: CurvedView!
    @IBOutlet weak var favoriteButtonImage: UIImageView!
    @IBOutlet weak var bookCollection: UICollectionView!
    
    // MARK: -ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bookDetailCollectionDataSource = BookDetailCollectionDataSource(collection: bookCollection)
        // Do any additional setup after loading the view.
        bind(to: viewModel)
        bind(to: bookDetailCollectionDataSource)
        viewModel.viewDidAppear()
        setUI()
    }
    
    // MARK: -Private methods
    
    private func bind(to viewModel: DetailViewModel) {
        viewModel.bookImageData = { [weak self] imageData in
            DispatchQueue.main.async {
                guard let image = UIImage(data: imageData) else {return}
                self?.bookImage.image = image
            }
        }
        
        viewModel.bookTitle = { [weak self] title in
            self?.bookTitle.text = title
        }
        
        viewModel.authorName = { [weak self] name in
            self?.bookAuthor.text = name
        }
        
        viewModel.favoriteStatus = { [weak self] status in
            self?.favoriteButtonImage.tintColor = (status == true) ? #colorLiteral(red: 0.1570077837, green: 0.1353155673, blue: 0.217381835, alpha: 1) : .white
            self?.favoriteButtonView.backgroundColor = (status == true) ? .white : #colorLiteral(red: 0.1570077837, green: 0.1353155673, blue: 0.217381835, alpha: 1)
        }
        
        viewModel.booksToDisplay = bookDetailCollectionDataSource.updateCells
    }
    
    private func bind(to dataSource: BookDetailCollectionDataSource) {
        dataSource.didSelectEvent = viewModel.display
    }
    
    private func setUI() {
        self.bookImage.layer.cornerRadius = 12
        self.view.bringSubviewToFront(favoriteButtonView)
        favoriteButtonImage.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tappedFav))
        favoriteButtonImage.addGestureRecognizer(gesture)
    }
    
    // MARK: -IB Actions
    
    @IBAction func dismiss(_ sender: UIButton) {
        viewModel.dismiss()
    }
    
    @objc private func tappedFav() {
        viewModel.favoritePressed()
    }
}
