//
//  LoginChoiceViewController.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 17/04/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginChoiceViewController: UIViewController, ViewControllerProtocol {

    /// Tag of the view
    let viewTag : ViewTag = .loginChoice
    /// Main `DisposeBag` of the `ViewController`
    let disposeBag = DisposeBag()
    /// Observable that informs that `Router` should route to the `Route`
    let onRouteTo : Observable<Route> = PublishSubject<Route>()
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet fileprivate weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
}

private extension LoginChoiceViewController {
    func bind() {
        loginButton
            .rx
            .tap
            .map {
                return Route(to: .mainTab, type: nil)
            }
            .bind(to: onRouteTo.asPublishSubject()!)
            .addDisposableTo(disposeBag)
    }
}
