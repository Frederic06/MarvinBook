//
//  CustomTableCell.swift
//  MarvinBook
//
//  Created by Margarita Blanc on 21/06/2020.
//  Copyright © 2020 Frederic Blanc. All rights reserved.
//

import UIKit

final class CustomTableCell: UITableViewCell {
    
//MARK: -Public Properties
    var openRecording: ((MarvinBook?) -> Void)?
    var shareRecording: ((MarvinBook?) -> Void)?
    
//MARK: -Private Properties
    private var index: Int?
    private var book: MarvinBook? {
        didSet {
            guard let book = book else { return }
            guard let url = URL(string: book.imageUrl) else {return}
            self.bookImage.layer.cornerRadius = 12
            if let data = try? Data( contentsOf: url) {
                guard let image = UIImage(data: data) else {return}
                self.bookImage.image = image
            }
            titleLabel.text = book.title
            authorLabel.text = book.author
            favoriteView.backgroundColor = (book.isFavorite == true) ? .white : #colorLiteral(red: 0.1561027765, green: 0.1395963728, blue: 0.2130003273, alpha: 1)
            favoriteImage.tintColor = (book.isFavorite == true) ? #colorLiteral(red: 0.1561027765, green: 0.1395963728, blue: 0.2130003273, alpha: 1) : .white
        }
    }

//MARK: -IB Outlets
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var favoriteView: CircleView!
    @IBOutlet weak var favoriteImage: UIImageView!
    
//MARK: -Public method
    func updateCell(with books: [MarvinBook]?, at index: Int) {
        self.index = index
        self.book = books?[index]
    }

}
