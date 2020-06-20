//
//  HomeRepository.swift
//  MarvinBook
//
//  Created by Margarita Blanc on 20/06/2020.
//  Copyright © 2020 Frederic Blanc. All rights reserved.
//

import Foundation

protocol MarvinBookRepositoryType: class {
    func download(requestType: Request, callback: @escaping ([MarvinBookModel]) -> Void) 
}

final class MarvinBookRepository: MarvinBookRepositoryType {

    // MARK: - Properties
    
    private let route: Route

    private let networkClient: HttpClient

    // MARK: - Init

    init(networkClient: HttpClient, route: Route) {
        self.networkClient = networkClient
        self.route = route
    }

    // MARK: - AudioPlayerRepositoryType

    func download(requestType: Request, callback: @escaping ([MarvinBookModel]) -> Void) {
        
        guard let url = route.getURL(request: requestType) else {return}
        
        networkClient.dataRequest(with: url, objectType: [MarvinBookModel].self) { (result: Result) in
            switch result {
            case .success(let object):

                print(object)
                print(object.count)
//                let books: [MarvinBook] = object.map{ return MarvinBook(id: $0.id, volume: $0.volume, title: $0.title, author: $0.author, imageUrl: $0.imageUrl)
//                }
                callback(object)
            case .failure(let error):
                print(error)
            }
        }
//        let request = URLRequest(url: url)
//        networkClient
//            .downloadTask(request, cancelledBy: cancellationToken)
//            .processDownloadResponse { (response) in
//                switch response.result {
//                case .success(let location):
//                    callback(location)
//                case .failure:
//                    callback(nil)
//                }
//        }
    }
}


