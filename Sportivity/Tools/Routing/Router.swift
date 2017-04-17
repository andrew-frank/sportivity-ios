//
//  Router.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 17/04/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import UIKit
import RxSwift

enum RoutingStyle {
    case push
    case modal
}

struct Route {
    let view : ViewTag
    let style : RoutingStyle?
    
    init(view: ViewTag, style: RoutingStyle? = nil) {
        self.view = view
        self.style = style
    }
}

class Router {
    let window : UIWindow
    fileprivate var currentNavigationController : UINavigationController? = nil
    fileprivate var mainTabBar : UITabBarController? = nil
    fileprivate let disposeBag = DisposeBag()
    
    init(window: UIWindow) {
        self.window = window
        let route = Route(view: .loginChoice)
        let vc = self.route(to: route)
        self.window.rootViewController = vc
        self.window.makeKeyAndVisible()
    }
    
    @discardableResult
    func route(to destination: Route) -> UIViewController {
        var destinationVC : UIViewController? = nil
        switch destination.view {
        case .loginChoice:
            let vc = R.storyboard.authorization.loginChoice()!
            window.set(rootViewController: vc)
            destinationVC = vc
        case .mainTab:
            // TODO: vc
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.red
            window.set(rootViewController: vc)
            destinationVC = vc
        }
        assert(destinationVC != nil, "destinationVC cannot be nil")
        return destinationVC!
    }
}
