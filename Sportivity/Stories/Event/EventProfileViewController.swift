//
//  EventViewController.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 07/05/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class EventProfileViewController: UIViewController, ViewControllerProtocol, Configurable {
    
    /// Tag of the view
    let viewTag : ViewTag = .event
    /// Main `DisposeBag` of the `ViewController`
    let disposeBag = DisposeBag()
    /// Observable that informs that `Router` should route to the `Route`
    let onRouteTo : Observable<Route> = PublishSubject<Route>()
    
    var viewModel: EventViewModel!
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Event"
        bind()
    }
}

private extension EventProfileViewController {
    func bind() {
        Observable<[EventViewModel]>.just([viewModel])
            .bind(to: tableView.rx.items) {
                tableView, row, viewModel in
                let indexPath = IndexPath(item: row, section: 0)
                
                let reuseId = R.reuseIdentifier.eventHeaderTableCell.identifier
                let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) //as! UserHeaderTableViewCell
                //cell.configure(with: viewModel)
                
                return cell
            }
            .addDisposableTo(disposeBag)
    }
}
