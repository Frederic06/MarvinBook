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
    func displayDetail(book: MarvinBook, books: [MarvinBook])
}

final class HomeViewModel {
    
    // MARK: -Private properties
    
    private let repository: MarvinBookRepositoryType
    
    private let delegate: HomeViewModelDelegate
    
    private var books: [MarvinBook]?
    
    private var favoriteBooks: [MarvinBook]? {
        didSet {
            guard let unwrapped = favoriteBooks else {return}
            for book in unwrapped {
                favoriteIDArray.append(book.id)
            }
            guard let unwrappedBooks = books else {return}
            let favoriteCheckedBooks = setFavorite(bookToSetFavorite: unwrappedBooks)
            self.books = favoriteCheckedBooks
            self.booksToDisplay?(favoriteCheckedBooks)
            self.booksToDisplayToCollection?(favoriteCheckedBooks)
            tableViewHidden?(false)
            self.savedBooks?(unwrapped)
        }
    }
    
    private var savedBooksArray: [MarvinBook]?
    
    private var favoriteIDArray: [String] = []
    
    // MARK: -Public properties
    
    var booksToDisplay: (([MarvinBook]) -> ())?
    var booksToDisplayToCollection: (([MarvinBook]) -> ())?
    var favTableViewHidden: ((Bool) -> ())?
    var globalBookViewHidden: ((Bool) -> ())?
    var attributedTitle: ((NSAttributedString) -> Void)?
    var buttonFavSelected: ((Bool) -> Void)?
    var savedBooks: (([MarvinBook]) -> ())?
    var tableViewHidden: ((Bool) -> ())?
    
    
    // MARK: -Init
    
    init(delegate: HomeViewModelDelegate, repository: MarvinBookRepositoryType) {
        self.repository = repository
        self.delegate = delegate
    }
    
    // MARK: -Public methods
    
    func viewDidAppear() {
        tableViewHidden?(true)
        downloadBooks()
        let titleAttributed = setHalfBold(normalText: "Marvin", boldText: "Book", fontSize: 25)
        attributedTitle?(titleAttributed)
    }
    
    func logOut() {
        delegate.loggedOut()
    }
    
    func display(book: MarvinBook?) {
        guard let book = book else {return}
        guard let books = books else {return}
        delegate.displayDetail(book: book, books: books)
    }
    
    func pressedSaveFavorite(book: MarvinBook?) {
        guard let book = book else {return}
        DispatchQueue.main.async {
            self.repository.saveBook(toSaveBook: book)
        }
    }
    
    func pressedSeeFavorite() {
        showFav()
    }
    
    func pressedSeeBooks() {
        showBooks()
    }
    
    // MARK: -Private methods
    
    private func showBooks() {
        viewDidAppear()
        resetArrays()
        favTableViewHidden?(true)
        globalBookViewHidden?(false)
        buttonFavSelected?(false)
    }
    
    private func showFav() {
        viewDidAppear()
        resetArrays()
        favTableViewHidden?(false)
        globalBookViewHidden?(true)
        buttonFavSelected?(true)
        guard let favorites = favoriteBooks else {return}
        self.savedBooks?(favorites)
    }
    
    private func downloadBooks() {
            self.repository.download(requestType: .marvin) { (books) in
                self.books = self.rename(books: books)
                self.getFavorites(completion: { (favoritesBooks) in
                    
                    self.favoriteBooks = favoritesBooks
                })
        }
    }
    
    private func checkFavorite(books: [MarvinBook]) -> [MarvinBook]{
        var bookArray = books
        for i in 0 ... bookArray.count - 1 {
            self.repository.checkIfFavorite(bookID: bookArray[i].id) { (state) in
                bookArray[i].isFavorite = state
                }
            }
        return bookArray
    }
    
    private func getFavorites(completion: @escaping ([MarvinBook]) -> ()?){
            guard let favorites = self.repository.getSavedBooks() else {return}
            completion(favorites)
    }
    
    private func setFavorite(bookToSetFavorite: [MarvinBook]) -> [MarvinBook]{
        var bookArray = bookToSetFavorite
        
        for i in 0...bookArray.count-1 {
            if favoriteIDArray.contains(bookArray[i].id) {
                bookArray[i].isFavorite = true
            } else {
                bookArray[i].isFavorite = false
            }
        }
        return bookArray
    }
    
    private func resetArrays() {
        favoriteIDArray = []
    }
    
    private func rename(books: [MarvinBook]) ->[MarvinBook] {
        var bookItem: [MarvinBook] = []
        for i in 0...books.count-1 {
            let title = "Tome \(i+1) - \(books[i].title)"
            let booked = MarvinBook(id: (books[i].id), volume: (books[i].volume), title: title, author: books[i].author, imageUrl: books[i].imageUrl)
            bookItem.append(booked)
        }
        return bookItem
    }
}
