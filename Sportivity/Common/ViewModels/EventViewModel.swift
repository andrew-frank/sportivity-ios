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

func ==(lhs: EventViewModel, rhs: EventViewModel) -> Bool {
    return lhs.identity == rhs.identity
}
