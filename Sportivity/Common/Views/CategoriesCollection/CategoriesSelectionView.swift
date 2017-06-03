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
        let selections = viewModel.selections.asObservable()
        selections
            .asObservable()
            .bind(to: collectionView.rx.items(cellIdentifier: R.reuseIdentifier.categorySelectionCollectionCell.identifier, cellType: CategorySelectionCollectionViewCell.self)) {
                index, vm, cell in
                cell.configure(with: vm)
            }
            .addDisposableTo(disposeBag)
        
        collectionView
            .rx.modelSelected(Category.self)
            .bind(to: viewModel.categorySelected)
            .addDisposableTo(disposeBag)
        
        collectionView
            .rx.modelDeselected(Category.self)
            .bind(to: viewModel.categoryDeselected)
            .addDisposableTo(disposeBag)
    }
}
