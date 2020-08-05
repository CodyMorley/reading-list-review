//
//  DetailViewController.swift
//  Reading List
//
//  Created by Bling Morley on 8/4/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    //MARK: - Properties -
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var reasonField: UITextView!
    
    var bookController: BookController?
    var book: Book?
    
    
    //MARK: - Life Cycles -
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    
    //MARK: - Actions -
    @IBAction func save(_ sender: Any) {
        guard let bookController = bookController,
            let title = titleField.text,
            let reason = reasonField.text,
            !title.isEmpty,
            title != "",
            !reason.isEmpty,
            reason != "" else {
                NSLog ("Need title & reason for reading to create new book for Reading List.")
                return
        }
        bookController.createBook(title, for: reason)
    }
    
    //MARK: - Methods -
    private func updateViews() {
        if let book = book {
            titleField.text = book.title
            reasonField.text = book.reasonToRead
        }
    }
}
