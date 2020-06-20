//
//  BookmarkViewModel.swift
//  MarvinBook
//
//  Created by Margarita Blanc on 20/06/2020.
//  Copyright © 2020 Frederic Blanc. All rights reserved.
//

import Foundation

protocol BookMarkViewModelDelegate {
    
}

final class BookMarkViewModel {
    
    private let delegate: BookMarkViewModelDelegate
    
    init(delegate: BookMarkViewModelDelegate) {
        self.delegate = delegate
    }
    
    func viewDidAppear() {
        
    }
}
