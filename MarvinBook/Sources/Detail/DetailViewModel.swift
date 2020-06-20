//
//  DetailViewModel.swift
//  MarvinBook
//
//  Created by Margarita Blanc on 20/06/2020.
//  Copyright © 2020 Frederic Blanc. All rights reserved.
//

import Foundation

protocol DetailViewModelDelegate {
    
}

final class DetailViewModel {
    private let delegate: DetailViewModelDelegate
    
    init(delegate: DetailViewModelDelegate) {
        self.delegate = delegate
    }
    
    func viewDidAppear() {
        
    }
}
