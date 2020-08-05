//
//  BookController.swift
//  Reading List
//
//  Created by Cody Morley on 8/4/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    //MARK: - Properties -
    var books: [Book] = []
    var readBooks: [Book] {
        books.filter { $0 .hasBeenRead == true }
    }
    var unreadBooks: [Book] {
        books.filter { $0 .hasBeenRead == false }
    }
    
    var readingListURL: URL? {
        let filMan = FileManager.default
        
        guard let docDir = filMan.urls(for: .documentDirectory,
                                       in: .userDomainMask).first
            else {
                NSLog("No document directory. Sorry we couldn't make that happen, Sport.")
                return nil
        }
        
        let readingListURL = docDir.appendingPathComponent("readingList").appendingPathExtension("plist")
        return readingListURL
    }
    
    
    //MARK: - Actions -
    func saveToPersistentStore(_ books: [Book]) {
        do {
            let booksData = try PropertyListEncoder().encode(books)
            guard let readingListURL = readingListURL else { return }
            try booksData.write(to: readingListURL)
        } catch {
            NSLog("Error encoding your property list. Buck up though, Chief; here's what happened: \(error) \(error.localizedDescription)")
            return
        }
    }
    
    func loadFromPersistentStore() {
        guard let readingListURL = readingListURL else { return }
        
        do {
            let readingList = try Data(contentsOf: readingListURL)
            let books = try PropertyListDecoder().decode([Book].self, from: readingList)
            self.books = books
        } catch {
            NSLog("Hey champ, I don't know how to say this but I couldn't read that list you gave me. Here's the issue: \(error) \(error.localizedDescription)")
            return
        }
    }
    
    
    //MARK: - CRUD Methods -
    func createBook(_ title: String, for reason: String) {
        let newBook = Book(title: title,
                           reasonToRead: reason)
        
        books.append(newBook)
        saveToPersistentStore(books)
    }
    
    func deleteBook(_ bookToDelete: Book) {
        var bookIndex = 0
        for book in books {
            if book == bookToDelete {
                books.remove(at: bookIndex)
                bookIndex += 1
                return
            }
            bookIndex += 1
        }
    }
    
    func updateHasBeenRead(_ book: inout Book) {
        book.hasBeenRead.toggle()
    }
    
    func updateBookStrings(_ book: inout Book, with newTitle: String?, for newReason: String?) {
        if let title = newTitle {
            book.title = title
        }
        
        if let reason = newReason {
            book.reasonToRead = reason
        }
    }
}
