//
//  bookCollectionDataSource.swift
//  MarvinBook
//
//  Created by Margarita Blanc on 20/06/2020.
//  Copyright © 2020 Frederic Blanc. All rights reserved.
//

import UIKit

final class BookCollectionDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private var books: [MarvinBook]? = nil
    
    private var collection: UICollectionView
    
    var didSelectEvent : ((MarvinBook?) -> Void)?
    
    init(collection: UICollectionView) {
        self.collection = collection
        super.init()
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
    }
    
    func updateCells(books: [MarvinBook]) {
        self.books = books
        DispatchQueue.main.async {
            self.collection.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (books == nil) ? 0 : books!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let data = self.books?[indexPath.item] else {return UICollectionViewCell()}
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! CustomCell
        cell.data = data
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height = collectionView.bounds.size.height - 35
        if indexPath.row == 0 {

        } else {
            height -= 20
        }
        return CGSize(width: height*0.7, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectEvent?(books?[indexPath.row])
    }
}
