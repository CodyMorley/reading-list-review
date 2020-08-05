//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Cody Morley on 8/4/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    //MARK: - Properties -
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var hasBeenReadButton: UIButton!
    
    weak var delegate: BookTableViewCellDelegate?
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - Life Cycles -
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    //MARK: - Actions -
    @IBAction func hasBeenReadTapped(_ sender: Any) {
        delegate?.toggleHasBeenRead(for: self)
    }
    
    
    
    
    //MARK: - Methods -
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func updateViews() {
        guard let book = book else { return }
        let checked = UIImage(named: "checked")!
        let unchecked = UIImage(named: "unchecked")!
        
        titleLabel.text = book.title
        switch book.hasBeenRead {
        case true:
            hasBeenReadButton.setImage(checked, for: .normal)
        case false:
            hasBeenReadButton.setImage(unchecked, for: .normal)
        }
    }

}
