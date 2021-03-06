//
//  Struct.swift
//  MarvinBook
//
//  Created by Margarita Blanc on 20/06/2020.
//  Copyright © 2020 Frederic Blanc. All rights reserved.
//

import Foundation

struct MarvinBook: Decodable {
        let id: String
        let volume: Int
        let title: String
        let author: String
        let imageUrl: String
        var isFavorite = false
}
