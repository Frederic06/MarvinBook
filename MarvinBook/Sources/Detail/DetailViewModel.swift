//
//  DetailViewModel.swift
//  MarvinBook
//
//  Created by Margarita Blanc on 20/06/2020.
//  Copyright © 2020 Frederic Blanc. All rights reserved.
//

import Foundation

protocol DetailViewModelDelegate {
    func displayOther(book: MarvinBook?, books: [MarvinBook])
    func dismissDetail()
    //    func favoritePressed(book: MarvinBook)
}

final class DetailViewModel {
        
//MARK: -Public properties
    var bookImageData: ((Data) -> ())?
    var bookTitle: ((String) -> ())?
    var authorName: ((String) -> ())?
    var booksToDisplay: (([MarvinBook]) -> ())?
    var favoriteStatus: ((Bool) -> ())?
    var tableViewHidden: ((Bool) -> ())?
    
//MARK: -Private properties
    private let delegate: DetailViewModelDelegate
    private var selectedBook: MarvinBook
    private let books: [MarvinBook]
    private let repository: MarvinBookRepositoryType

    
//MARK: -Init
    init(delegate: DetailViewModelDelegate, book: MarvinBook, books: [MarvinBook], repository: MarvinBookRepositoryType) {
        self.delegate = delegate
        self.selectedBook = book
        self.books = books
        self.repository = repository
    }
    
    //MARK: -Public methods
    func viewDidAppear() {
        booksToDisplay?(books)
        guard let url = URL(string: selectedBook.imageUrl) else {return}
        if let data = try? Data( contentsOf: url) {
            bookImageData?(data)
        }
        bookTitle?(selectedBook.title)
        authorName?(selectedBook.author)
        favoriteStatus?(selectedBook.isFavorite)
    }
    
    func dismiss() {
        delegate.dismissDetail()
    }
    
    func favoritePressed() {
        if selectedBook.isFavorite == true {
            repository.removeFavorite(bookID: selectedBook.id)
        } else {
            repository.saveBook(toSaveBook: selectedBook)
        }
        selectedBook.isFavorite = !(selectedBook.isFavorite)
        favoriteStatus?(selectedBook.isFavorite)
    }
    
    func display(book: MarvinBook?) {
        guard let book = book else {return}
        delegate.displayOther(book: book, books: books)
    }
}
