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

class UserProfileViewController: UIViewController, ViewControllerProtocol {
    
    /// Tag of the view
    let viewTag : ViewTag = .user
    /// Main `DisposeBag` of the `ViewController`
    let disposeBag = DisposeBag()
    /// Observable that informs that `Router` should route to the `Route`
    let onRouteTo : Observable<Route> = PublishSubject<Route>()

    @IBOutlet fileprivate weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Profile"
        bind()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.navigationBar.isHidden = true
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.navigationBar.isHidden = false
//    }
}

private extension UserProfileViewController {
    func bind() {
        Observable<[UserProfileHeaderViewModel]>.just([UserProfileHeaderViewModel()])
            .bind(to: tableView.rx.items) {
                tableView, row, viewModel in
                let indexPath = IndexPath(item: row, section: 0)
                
                let reuseId = R.reuseIdentifier.userHeaderTableCell.identifier
                let cell = tableView.dequeueReusableCell(withIdentifier: reuseId, for: indexPath) as! UserProfileHeaderTableViewCell
                cell.configure(with: viewModel)
                
                return cell
            }
            .addDisposableTo(disposeBag)
    }
}
