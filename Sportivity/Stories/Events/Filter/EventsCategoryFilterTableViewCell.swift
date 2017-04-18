//
//  EventsCategoryFilterTableViewCell.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 18/04/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import UIKit

class EventsCategoryFilterTableViewCell: UITableViewCell {

    @IBOutlet fileprivate weak var categoriesCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
}

private extension EventsCategoryFilterTableViewCell {
    func setup() {
        categoriesCollectionView.register(EventsCategoryFilterCollectionViewCell.self, forCellWithReuseIdentifier: R.reuseIdentifier.eventsCategoryFilterCollectionCell.identifier)
    }
}
