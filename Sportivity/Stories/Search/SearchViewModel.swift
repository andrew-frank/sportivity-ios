//
//  SearchViewModel.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 19/04/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum SearchType {
    case users
    case events
    case places
}

class SearchViewModel {
    let data = Variable<[UserViewModel]>([ ])
    let type = Variable<SearchType>(.users)
    let searchQuery = Variable<String?>(nil)
    
    fileprivate let disposeBag = DisposeBag()
    
    init() {
//        Observable.combineLatest(searchQuery.asObservable(), type.asObservable() ) { (query, type) -> Observable<[ListingViewModelProtocol]> in
//            switch type {
//            case .users:
//                let obs : Observable<[ListingViewModelProtocol]> = UserAPI.rx_search(name: query).map {
//                    return $0.map {
//                        return UserViewModel(user: $0)
//                    }
//                }
//                
//                return obs
//            default:
//                return Observable<[ListingViewModelProtocol]>.just([ ])
//            }
//        }
        
        UserAPI
            .rx_search(name: nil)
            .catchErrorJustReturn([ ]).map { (users) -> [UserViewModel] in
                return users.map { UserViewModel.init(user: $0) }
            }
            .bind(to: data)
            .addDisposableTo(disposeBag)
    }
    
}
