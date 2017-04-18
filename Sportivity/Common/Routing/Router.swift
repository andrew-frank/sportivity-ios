//
//  Router.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 17/04/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import UIKit
import RxSwift

enum ViewTag {
    case loginChoice
    //    case loginEmail
    //    case registerEmail
    
    case mainTab
    //    case feed
    //    case map
    //
    //    case user
    //    case place
    //    case event
}

enum RouteType {
    case push
    case modal
    case tabSwitch
    case windowRootSwap
}

struct Route {
    let view : ViewTag
    let type : RouteType?
    
    init(to view: ViewTag, type: RouteType? = nil) {
        self.view = view
        self.type = type
    }
    
    private func defaultType(for viewTag: ViewTag) -> RouteType {
        switch viewTag {
        case .loginChoice, .mainTab:
            return .windowRootSwap
        }
    }
}

class Router {
    let window : UIWindow
    fileprivate var currentNavigationController : UINavigationController? = nil
    fileprivate var mainTabBarController : MainTabBarViewController? = nil
    fileprivate let disposeBag = DisposeBag()
    
    init(window: UIWindow) {
        self.window = window
        let route = Route(to: .loginChoice)
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
            mainTabBarController = R.storyboard.mainTab.mainTab()!
            window.set(rootViewController: mainTabBarController!)
            destinationVC = mainTabBarController
        }
        
        assert(destinationVC != nil, "destinationVC cannot be nil")
        guard let destinationVcProtocol = destinationVC as? ViewControllerProtocol else {
            fatalError("destinationVC does not conform to ViewControllerProtocol")
        }
        
        destinationVcProtocol
            .onRouteTo
            .subscribeNext({ [unowned self] (route) in
                self.route(to: route)
            })
            .addDisposableTo(disposeBag)
        
        return destinationVC!
    }
}
