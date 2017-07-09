//
//  PlaceProfileViewController.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 09/07/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PlaceProfileViewController: UIViewController, ViewControllerProtocol, Configurable {
    
    /// Tag of the view
    let viewTag : ViewTag = .place
    /// Main `DisposeBag` of the `ViewController`
    let disposeBag = DisposeBag()
    /// Observable that informs that `Router` should route to the `Route`
    let onRouteTo : Observable<Route> = PublishSubject<Route>()
    
    var viewModel: PlaceProfileViewModel!
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Place"
        tableView.register(R.nib.eventTableViewCell(), forCellReuseIdentifier: R.reuseIdentifier.eventTableViewCell.identifier)
        tableView.rx.setDelegate(self).addDisposableTo(disposeBag)
        bind()
    }
    
    private func bind() {
        viewModel
            .cellsData
            .asObservable()
            .bind(to: tableView.rx.items) {
                tableView, row, item in
                let indexPath = IndexPath(item: row, section: 0)
                
                var cell: UITableViewCell!
                switch item {
//                case let vm as EventProfileHeaderViewModel:
//                    let reuseId = R.reuseIdentifier.eventHeaderTableCell.identifier
//                    cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)
//                    let cell = cell as! EventProfileHeaderTableViewCell
//                    cell.configure(with: vm)
                case let vm as EventViewModel:
                    let reuseId = R.reuseIdentifier.eventTableViewCell
                    cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)
                    let cell = cell as! EventTableViewCell
                    cell.configure(with: vm)
                default:
                    assert(false)
                    break
                }
                
                return cell
            }
            .addDisposableTo(disposeBag)
        
        tableView
            .rx.modelSelected(EventViewModel.self)
            .map { (user) -> Route in
                return Route(to: .user, type: nil, data: user)
            }
            .bind(to: onRouteTo.asPublishSubject()!)
            .addDisposableTo(disposeBag)
        
        tableView
            .rx.itemSelected
            .asObservable()
            .subscribeNext { [unowned self] (indexPath) in
                self.tableView.deselectRow(at: indexPath, animated: true)
            }
            .addDisposableTo(disposeBag)
    }
}

extension PlaceProfileViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:     return 516
        default:    return 50
        }
    }
}
