//
//  MapViewController.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 08/06/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MapViewController: UIViewController, ViewControllerProtocol, Configurable  {

    /// Tag of the view
    let viewTag : ViewTag = .events
    /// Main `DisposeBag` of the `ViewController`
    let disposeBag = DisposeBag()
    /// Observable that informs that `Router` should route to the `Route`
    let onRouteTo : Observable<Route> = PublishSubject<Route>()

    var viewModel: MapViewModel! = MapViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
