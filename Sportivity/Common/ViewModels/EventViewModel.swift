//
//  EventViewModel.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 18/04/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import Foundation
import RxDataSources
import RxSwift

class EventViewModel : IdentifiableType, Equatable {
    typealias Identity = String
    let identityID: String = UUID().uuidString
    var identity: String {
        return identityID
    }
}

extension EventViewModel : ListingViewModelProtocol {
    
    // TODO: ListingViewModelProtocol once other data is there
    
    var id : String {
        return identity
    }
    
    var title : Observable<String> {
        return Observable<String>.just("Event")
    }
    
    var imageUrl : Observable<NSURL?> {
        return Observable<NSURL?>.just(nil)
    }
}

func ==(lhs: EventViewModel, rhs: EventViewModel) -> Bool {
    return lhs.identity == rhs.identity
}
