//
//  UserViewController.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 19/04/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class UserProfileViewController: UIViewController, ViewControllerProtocol, Configurable {
    
    /// Tag of the view
    let viewTag : ViewTag = .user
    /// Main `DisposeBag` of the `ViewController`
    let disposeBag = DisposeBag()
    /// Observable that informs that `Router` should route to the `Route`
    let onRouteTo : Observable<Route> = PublishSubject<Route>()

    @IBOutlet fileprivate weak var tableView: UITableView!
    
    var viewModel: UserProfileViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Profile"
        tableView.register(R.nib.eventTableViewCell(), forCellReuseIdentifier: R.reuseIdentifier.eventTableViewCell.identifier)
        bind()
    }
}

private extension UserProfileViewController {
    func bind() {
        viewModel
            .cellsData
            .asDriver()
            .drive(tableView.rx.items) {
                tableView, row, item in
                let indexPath = IndexPath(item: row, section: 0)
                
                var cell: UITableViewCell!
                switch item {
                case let vm as UserProfileHeaderViewModel:
                    let reuseId = R.reuseIdentifier.userHeaderTableCell.identifier
                    cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath)
                    let cell = cell as! UserProfileHeaderTableViewCell
                    cell.configure(with: vm)
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
    }
}
