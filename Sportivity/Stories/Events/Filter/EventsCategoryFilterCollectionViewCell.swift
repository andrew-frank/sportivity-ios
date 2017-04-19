//
//  EventsCategoryCollectionViewCell.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 18/04/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import UIKit

class EventsCategoryFilterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet fileprivate weak var imageView: UIImageView!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    
    fileprivate var category: CategorySelection? = nil
    
    func set(categorySelection: CategorySelection) {
        imageView.image = categorySelection.category.iconImage
        titleLabel.text = categorySelection.category.name
    }
}
