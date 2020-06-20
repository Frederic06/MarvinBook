//
//  bookCollectionDataSource.swift
//  MarvinBook
//
//  Created by Margarita Blanc on 20/06/2020.
//  Copyright © 2020 Frederic Blanc. All rights reserved.
//

import UIKit

final class BookCollectionDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private var books: [MarvinBookModel]? = nil
    
    private var collection: UICollectionView
    
    private var selectedIndexPath: IndexPath?
    
    var didSelectEvent : ((MarvinBookModel) -> Void)?
    
    init(collection: UICollectionView) {
        self.collection = collection
        super.init()
        collection.dataSource = self
        collection.delegate = self
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
    }
    
    func updateCells(books: [MarvinBookModel]) {
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
        selectedIndexPath = indexPath
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as! CustomCell
        cell.data = data
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath == selectedIndexPath {
            return CGSize(width: 200, height: 90)
        } else {
            return CGSize(width: 180, height: 80)
        }
    }
    
}
