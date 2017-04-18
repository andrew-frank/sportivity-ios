//
//  GamesCategoryFilterTableViewCell.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 18/04/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import UIKit

class GamesCategoryFilterTableViewCell: UITableViewCell {

    @IBOutlet fileprivate weak var categoriesCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
}

private extension GamesCategoryFilterTableViewCell {
    func setup() {
        categoriesCollectionView.register(GamesCategoryCollectionViewCell.self, forCellWithReuseIdentifier: R.reuseIdentifier.gamesCategoryFilterCollectionCell.identifier)
    }
}
