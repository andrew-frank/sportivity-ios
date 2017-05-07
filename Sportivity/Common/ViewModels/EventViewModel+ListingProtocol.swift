//
//  EventViewModel+ListingProtocol.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 07/05/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import Foundation
import RxSwift

extension EventViewModel : ListingViewModelProtocol {
    
    // TODO: ListingViewModelProtocol once other data is there
    
    var id : String {
        return identity
    }
    
    var title : Observable<String> {
        return name.asObservable()
    }
    
    var imageUrl : Observable<NSURL?> {
        return Observable<NSURL?>.just(nil)
    }
}

func ==(lhs: EventViewModel, rhs: EventViewModel) -> Bool {
    return lhs.identity == rhs.identity
}
