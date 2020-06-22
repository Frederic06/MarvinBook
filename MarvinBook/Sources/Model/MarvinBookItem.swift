//
//  MarvinBookItem.swift
//  MarvinBook
//
//  Created by Margarita Blanc on 21/06/2020.
//  Copyright © 2020 Frederic Blanc. All rights reserved.
//

import Foundation

struct MarvinBookItem: Decodable {
        let id: String
        let volume: Int
        let title: String
        let author: String
        let imageUrl: String
}
