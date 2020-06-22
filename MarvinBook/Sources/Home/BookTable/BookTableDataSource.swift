//
//  BookTableDataSource.swift
//  MarvinBook
//
//  Created by Margarita Blanc on 20/06/2020.
//  Copyright © 2020 Frederic Blanc. All rights reserved.
//

import UIKit

final class BookTableDataSource: NSObject, UITableViewDelegate, UITableViewDataSource{
    
//MARK: -Public Properties
    var open: ((MarvinBook) -> Void)?
    
//MARK: -Private Properties
    private var tableView: UITableView
    private var books: [MarvinBook]?
    
//MARK: -Init
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
//MARK: -Public methods
    func update(array: [MarvinBook]) {
        self.books = array
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let number = books?.count else {return 0}
        return number
    }
    
//MARK: -Public methods
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 30))
        returnedView.backgroundColor = .clear
        
        let label = UILabel(frame: CGRect(x: 10, y: 7, width: tableView.frame.size.width, height: 30))
        
        let font = UIFont(name: "AvenirNext-Bold", size: 20)
        let attrs = [NSAttributedString.Key.font : font]
        let attributedString = NSMutableAttributedString(string:"Best Seller", attributes:attrs as [NSAttributedString.Key : Any])
        
        label.attributedText = attributedString
        label.textColor = .white
        returnedView.addSubview(label)
        
        return returnedView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard (books?[indexPath.row]) != nil else {return UITableViewCell()}
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as! CustomTableCell
        cell.updateCell(with: books, at: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let book = books?[indexPath.row] else {return}
        open?(book)
    }
}
