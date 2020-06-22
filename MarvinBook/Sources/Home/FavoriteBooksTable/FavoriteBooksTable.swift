//
//  FavoriteBooksTable.swift
//  MarvinBook
//
//  Created by Margarita Blanc on 21/06/2020.
//  Copyright © 2020 Frederic Blanc. All rights reserved.
//


import UIKit

final class FavoriteBooksTable: NSObject, UITableViewDelegate, UITableViewDataSource{
    
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard (books?[indexPath.row]) != nil else {return UITableViewCell()}
        let cell = tableView.dequeueReusableCell(withIdentifier: "favBookCell", for: indexPath) as! CustomTableCell
        cell.updateCell(with: books, at: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let book = books?[indexPath.row] else {return}
        open?(book)
    }
}
