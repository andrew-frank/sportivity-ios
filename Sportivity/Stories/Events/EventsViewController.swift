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


class EventsViewController: UIViewController, ViewControllerProtocol, Configurable {

    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var categoryFilterCollectionView: UICollectionView!
    
    var viewModel: EventsViewModel! = EventsViewModel()
    
    /// Tag of the view
    let viewTag : ViewTag = .events
    /// Main `DisposeBag` of the `ViewController`
    let disposeBag = DisposeBag()
    /// Observable that informs that `Router` should route to the `Route`
    let onRouteTo : Observable<Route> = PublishSubject<Route>()
    
    fileprivate let tableDataSource = RxTableViewSectionedAnimatedDataSource<EventsSection>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(R.nib.eventTableViewCell(), forCellReuseIdentifier: R.reuseIdentifier.eventTableViewCell.identifier)
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
            .bind(to: categoryFilterCollectionView.rx.items(cellIdentifier: R.reuseIdentifier.eventsCategoryFilterCollectionCell.identifier, cellType: EventsCategoryFilterCollectionViewCell.self)) {
                index, category, cell in
                cell.set(categorySelection: category)
            }
            .addDisposableTo(disposeBag)
    }
    
    func bindTableView() {
        tableDataSource.configureCell = { dataSource, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.eventTableViewCell.identifier)! as! EventTableViewCell
            cell.configure(with: item)
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
        
        tableView
            .rx.modelSelected(EventViewModel.self)
            .map { vm -> Route in
                return Route(to: .event, type: nil, data: vm)
            }
            .bind(to: onRouteTo.asPublishSubject()!)
            .addDisposableTo(disposeBag)
    }
}
