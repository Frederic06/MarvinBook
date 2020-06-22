//
//  Network.swift
//  MarvinBook
//
//  Created by Margarita Blanc on 20/06/2020.
//  Copyright © 2020 Frederic Blanc. All rights reserved.
//

import Foundation

enum Request {
    case marvin
}

final class Route {
    private let marvinBookURLString = "https://next.json-generator.com/api/json/get/Vy0sPkEvO?delay=1200"
}

// MARK: - URL Return
extension Route {
    
    func getURL(request: Request) -> URL? {
        var urlString: String
        switch request {
        case .marvin:
            urlString = marvinBookURLString
        }

        return URL(string: urlString)
    }
}
