//
//  GamesViewController.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 18/04/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

private struct EventsSection {
    var header: String
    var items: [Item]
}

extension EventsSection: AnimatableSectionModelType  {
    typealias Item = EventViewModel
    typealias Identity = String
    
    var identity: String {
        return header
    }
    
    init(original: EventsSection, items: [Item]) {
        self = original
        self.items = items
    }
}


class EventsViewController: UIViewController, Configurable {

    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var categoryFilterCollectionView: UICollectionView!
    
    var viewModel: EventsViewModel! = EventsViewModel()
    
    let disposeBag = DisposeBag()
    fileprivate let tableDataSource = RxTableViewSectionedAnimatedDataSource<EventsSection>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableDataSource.animationConfiguration = AnimationConfiguration()
        bindTableView()
        bindFilter()
    }
}

private extension EventsViewController {
    func bindFilter() {
        viewModel
            .categories
            .asObservable()
            .debug()
            .bind(to: categoryFilterCollectionView.rx.items(cellIdentifier: R.reuseIdentifier.eventsCategoryFilterCollectionCell.identifier, cellType: EventsCategoryFilterCollectionViewCell.self)) {
                index, category, cell in
                cell.set(categorySelection: category)
            }
            .addDisposableTo(disposeBag)
    }
    
    func bindTableView() {
        tableDataSource.configureCell = { dataSource, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.eventTableViewCell.identifier)!
            return cell
        }
        
        viewModel
            .events
            .asObservable()
            .map { (events) -> [EventsSection] in
                let section = EventsSection(header: "", items: events)
                return [section]
            }
            .bind(to: tableView.rx.items(dataSource: self.tableDataSource))
            .addDisposableTo(disposeBag)
    }
}
