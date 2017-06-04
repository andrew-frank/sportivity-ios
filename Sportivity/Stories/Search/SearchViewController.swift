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
    
    @IBOutlet weak var usersButton: UIButton!
    @IBOutlet weak var eventsButton: UIButton!
    @IBOutlet weak var placesButton: UIButton!
    
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
        
        usersButton.rx.tap.map { SearchType.users }.bind(to: viewModel.type).addDisposableTo(disposeBag)
        eventsButton.rx.tap.map { SearchType.events }.bind(to: viewModel.type).addDisposableTo(disposeBag)
        placesButton.rx.tap.map { SearchType.places }.bind(to: viewModel.type).addDisposableTo(disposeBag)
        
        viewModel
            .type
            .asObservable()
            .subscribeNext { [unowned self] (type) in
                self.usersButton.isSelected = type == .users
                self.eventsButton.isSelected = type == .events
                self.placesButton.isSelected = type == .places
                self.tableView.isHidden = type != .users
            }
            .addDisposableTo(disposeBag)
    }
}
