//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Cody Morley on 8/4/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {
    //MARK: - Properties -
    var bookController = BookController()
    
    
    // MARK: - Life Cycles -
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Table View Data Source -
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return bookController.unreadBooks.count
        } else if section == 1 {
            return bookController.readBooks.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else { fatalError("Could not dequeue cell with identifier 'BookCell'.") }
        
        cell.book = bookFor(indexPath: indexPath)
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            bookController.deleteBook(bookFor(indexPath: indexPath))
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Unread"
        } else if section == 1 {
            return "Read"
        } else {
            return " "
        }
    }

    
    // MARK: - Navigation -
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "DetailSegue":
            let indexPath = IndexPath(index: tableView!.indexPathForSelectedRow!.row)
            guard let detailVC = segue.destination as? DetailViewController else {
                fatalError("No such segue")
            }
            
            detailVC.bookController = bookController
            detailVC.book = bookFor(indexPath: indexPath)
        case "AddSegue":
            guard let addVC = segue.destination as? DetailViewController else {
                fatalError("No such segue")
            }
            addVC.bookController = bookController
        default:
            fatalError("No such segue.")
        }
    }
    
    
    //MARK: - Methods -
    private func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }

}



//MARK: - Extensions -
extension ReadingListTableViewController: BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        if let book = cell.book {
            for var savedBook in bookController.books {
                if book == savedBook {
                    bookController.updateHasBeenRead(&savedBook)
                }
            }
        }
    }
    
    
}
