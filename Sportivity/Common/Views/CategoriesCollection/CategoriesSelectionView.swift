//
//  CategoriesSelectionView.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 26/05/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CategoriesSelectionView : NibLoadingView, Configurable {
    
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    fileprivate let disposeBag = DisposeBag()

    var viewModel: CategoriesSelectionViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.allowsMultipleSelection = true
        let nib = UINib(nibName: "CategorySelectionCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: R.reuseIdentifier.categorySelectionCollectionCell.identifier)
    }
    
    func configure() {
        viewModel
            .selections
            .asObservable()
            .bind(to: collectionView.rx.items(cellIdentifier: R.reuseIdentifier.categorySelectionCollectionCell.identifier, cellType: CategorySelectionCollectionViewCell.self)) {
                index, category, cell in
                cell.configure(with: category)
            }
            .addDisposableTo(disposeBag)
    }
}
