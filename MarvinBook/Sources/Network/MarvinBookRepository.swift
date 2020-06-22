//
//  HomeRepository.swift
//  MarvinBook
//
//  Created by Margarita Blanc on 20/06/2020.
//  Copyright © 2020 Frederic Blanc. All rights reserved.
//

import Foundation
import CoreData

protocol MarvinBookRepositoryType: class {
    func download(requestType: Request, callback: @escaping ([MarvinBook]) -> Void)
    func saveBook(toSaveBook: MarvinBook)
    func getSavedBooks() -> [MarvinBook]?
    func removeFavorite(bookID: String)
    func checkIfFavorite(bookID: String, completion: (Bool) -> Void)
}

protocol RepositoryDelegate {
    func error()
}

final class MarvinBookRepository: MarvinBookRepositoryType {
    
    // MARK: - Properties
    
    private let route: Route
    
    private let networkClient: HttpClient
    
    private let delegate: RepositoryDelegate
    
    // MARK: - Init
    
    init(networkClient: HttpClient, route: Route, delegate: RepositoryDelegate) {
        self.networkClient = networkClient
        self.route = route
        self.delegate = delegate
    }
    
    // MARK: - Public methods
    
    func download(requestType: Request, callback: @escaping ([MarvinBook]) -> Void) {
        
        guard let url = route.getURL(request: requestType) else {return}
        
        networkClient.dataRequest(with: url, objectType: [MarvinBookItem].self) { (result: Result) in
            switch result {
            case .success(let object):
                let books: [MarvinBook] = object.map {
                    return MarvinBook(id: $0.id, volume: $0.volume, title: $0.title, author: $0.author, imageUrl: $0.imageUrl)
                }
                callback(books)
            case .failure( _):
                self.delegate.error()
            }
        }
    }
    
    func saveBook(toSaveBook: MarvinBook) {
            let book = BookItem(context: AppDelegate.viewContext)
            book.title = toSaveBook.title
            book.author = toSaveBook.author
            book.id = toSaveBook.id
            book.imageUrl = toSaveBook.imageUrl
            try? AppDelegate.viewContext.save()
    }
    
    func getSavedBooks() -> [MarvinBook]?{
        
        let request: NSFetchRequest<BookItem> = BookItem.fetchRequest()
        guard let fetchedBooks = try? AppDelegate.viewContext.fetch(request) else {return nil}
        let marvinBooks = fetchedBooks.map({return MarvinBook(id: $0.id!, volume: 0, title: $0.title!, author: $0.author!, imageUrl: $0.imageUrl!, isFavorite: true)})
        return marvinBooks
    }
    
    func removeFavorite(bookID: String) {
        
            let request: NSFetchRequest<BookItem> = BookItem.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", bookID)
            
        do {
            let object = try AppDelegate.viewContext.fetch(request)
            if !object.isEmpty {
                AppDelegate.viewContext.delete(object[0])
                try? AppDelegate.viewContext.save()
            }
        } catch _ as NSError {
        }
    }
    
    func checkIfFavorite(bookID: String, completion: (Bool) -> Void) {
        let request: NSFetchRequest<BookItem> = BookItem.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", bookID)
        request.sortDescriptors = [NSSortDescriptor(keyPath: \BookItem.id, ascending: true)]
        
        guard let book = try? AppDelegate.viewContext.fetch(request) else { print("error") ; return }
        
        if book == [] {completion(false); return }
        
        completion(true)
    }
}
