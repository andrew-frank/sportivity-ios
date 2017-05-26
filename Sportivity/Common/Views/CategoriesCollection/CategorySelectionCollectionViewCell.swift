//
//  CategorySelectionCollectionViewCell.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 26/05/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CategorySelectionCollectionViewCell: UICollectionViewCell, Configurable {
    
    @IBOutlet fileprivate weak var imageView: UIImageView!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    
    var viewModel: CategorySelection!
    
    fileprivate var reuseBag = DisposeBag()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reuseBag = DisposeBag()
    }
    
    override var isSelected: Bool {
        didSet {
            if viewModel.isSelected.value != isSelected {
                viewModel.isSelected.value = isSelected
            }
        }
    }
    
    func configure() {
        imageView.image = viewModel.category.iconImage
        titleLabel.text = viewModel.category.name
        viewModel
            .isSelected
            .asObservable()
            .subscribeNext { [unowned self] (isSelected) in
                self.isSelected = isSelected
                self.imageView.alpha = isSelected ? 1 : 0.5
                self.titleLabel.alpha = isSelected ? 1 : 0.5
            }
            .addDisposableTo(reuseBag)
    }
}
