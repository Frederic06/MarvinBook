//
//  HomeViewModel.swift
//  MarvinBook
//
//  Created by Margarita Blanc on 20/06/2020.
//  Copyright © 2020 Frederic Blanc. All rights reserved.
//

import Foundation

protocol HomeViewModelDelegate {
        func loggedOut()
}

final class HomeViewModel {
    
    // MARK: -Private properties
    
    private let repository: MarvinBookRepositoryType
    
    private let delegate: HomeViewModelDelegate
    
    // MARK: -Public properties
    
    var booksToDisplay: (([MarvinBookModel]) -> ())?

    var attributedTitle: ((NSAttributedString) -> Void)?
    
    // MARK: -Init
    
    init(delegate: HomeViewModelDelegate, repository: MarvinBookRepositoryType) {
        self.repository = repository
        self.delegate = delegate
    }
    
    // MARK: -Public methods
    
    func viewDidAppear() {
        let titleAttributed = setHalfBold(normalText: "Marvin", boldText: "Book", fontSize: 25)
        attributedTitle?(titleAttributed)
        
        repository.download(requestType: .marvin) { (books) in
            self.booksToDisplay?(books)
        }
    }
    
    func logOut() {
        delegate.loggedOut()
    }
    
    func display(book: MarvinBookModel) {
        print(book.title)
    }
    
    // MARK: -Private methods
    
}
