//
//  ListingTableViewCell.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 19/04/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import UIKit

class ListingTableViewCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var avatarImageView: AvatarImageView!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    
    fileprivate var viewModel: ListingViewModelProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func set(viewModel: ListingViewModelProtocol) {
        self.viewModel = viewModel
        // TODO: configure
    }
}
