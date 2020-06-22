//
//  CustomCollectionCell.swift
//  MarvinBook
//
//  Created by Margarita Blanc on 20/06/2020.
//  Copyright © 2020 Frederic Blanc. All rights reserved.
//

import UIKit

class CustomCell: UICollectionViewCell {
    
    var data: MarvinBook? {
        didSet {
            guard let data = data else { return }
            isFavorite = data.isFavorite
            setUI()
            guard let url = URL(string: data.imageUrl) else {return}
            if let data = try? Data( contentsOf: url) {
                guard let image = UIImage(data: data) else {return}
                self.bg.image = image
            }
        }
    }
    
    private var isFavorite = false
    
    fileprivate let bg: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        return iv
    }()
    
    fileprivate let favoriteView: CircleView = {
        let view = CircleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        view.isUserInteractionEnabled = true
        return view
    }()
    
    fileprivate let favoriteImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(systemName: "bookmark.fill")
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    fileprivate let button: UIButton = {
        let iv = UIButton()
        iv.backgroundColor = .red
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setUI() {
        contentView.addSubview(bg)
        bg.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bg.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        bg.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        bg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        bg.addSubview(favoriteView)
        NSLayoutConstraint.activate([
            favoriteView.bottomAnchor.constraint(equalTo: bg.bottomAnchor, constant: -20),
            favoriteView.rightAnchor.constraint(equalTo: bg.rightAnchor, constant: -12),
            favoriteView.heightAnchor.constraint(equalToConstant: 40),
            favoriteView.widthAnchor.constraint(equalToConstant: 40),
        ])
        bg.bringSubviewToFront(favoriteView)
        
        favoriteView.layer.zPosition = 1
        self.bringSubviewToFront(favoriteView)
        
        favoriteView.addSubview(favoriteImage)
        favoriteView.bringSubviewToFront(favoriteImage)
        NSLayoutConstraint.activate([
            favoriteImage.centerXAnchor.constraint(lessThanOrEqualTo: favoriteView.centerXAnchor),
            favoriteImage.centerYAnchor.constraint(lessThanOrEqualTo: favoriteView.centerYAnchor),
            favoriteImage.heightAnchor.constraint(equalToConstant: 20),
            favoriteImage.widthAnchor.constraint(equalToConstant: 20)
        ])
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tappedFavorite))
        favoriteImage.addGestureRecognizer(gesture)
        favoriteView.addGestureRecognizer(gesture)
        
        favoriteView.backgroundColor = (isFavorite == false) ? #colorLiteral(red: 0.311314702, green: 0.2611939013, blue: 0.4847460389, alpha: 1) : .white
        favoriteImage.tintColor = (isFavorite == false) ? .white : #colorLiteral(red: 0.1570077837, green: 0.1353155673, blue: 0.217381835, alpha: 1)
        
    }
    
    @objc private func tappedFavorite() {
        print("favorite")
    }

    
    
}
