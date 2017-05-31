//
//  SearchViewController.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 19/04/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

private struct SearchViewControllerConstants {
    static let tableTopInset = CGFloat(109-20) //search header height - status bar
}

private typealias C = SearchViewControllerConstants

class SearchViewController: UIViewController, Configurable {

    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var searchBar: UISearchBar!
    
    var viewModel: SearchViewModel! = SearchViewModel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsetsMake(C.tableTopInset, 0, 0, 0)
        tableView.register(R.nib.listingTableViewCell(), forCellReuseIdentifier: R.reuseIdentifier.listingTableCell.identifier)
        bind()
    }
}

private extension SearchViewController {
    func bind() {
        viewModel
            .data
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: R.reuseIdentifier.listingTableCell.identifier, cellType: ListingTableViewCell.self)) {
                index, item, cell in
                cell.configure(with: item)
            }
            .addDisposableTo(disposeBag)
        
    }
}
