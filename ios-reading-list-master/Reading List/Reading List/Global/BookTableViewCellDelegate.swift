//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Cody Morley on 8/4/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate: AnyObject {
    func toggleHasBeenRead(for cell: BookTableViewCell)
}
