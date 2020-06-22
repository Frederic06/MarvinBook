//
//  CustomDetailCell.swift
//  MarvinBook
//
//  Created by Margarita Blanc on 21/06/2020.
//  Copyright © 2020 Frederic Blanc. All rights reserved.
//


import UIKit

class CustomDetailCell: UICollectionViewCell {
    
//MARK: -Public propertie
    var data: MarvinBook? {
        didSet {
            guard let data = data else { return }
            guard let url = URL(string: data.imageUrl) else {return}
            if let data = try? Data( contentsOf: url) {
                guard let image = UIImage(data: data) else {return}
                self.bookImage.layer.cornerRadius = 12
                self.bookImage.image = image
            }
        }
    }

//MARK: -IBOutlet
    @IBOutlet weak var bookImage: UIImageView!
    
//MARK: -Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
