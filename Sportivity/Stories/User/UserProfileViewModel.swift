//
//  UserViewModel.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 19/04/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class UserProfileViewModel {
    
    let events = Variable<[EventViewModel]>([ ])
    
    init() {
        var arr = [EventViewModel]()
        arr.append(EventViewModel(event: Event()))
        arr.append(EventViewModel(event: Event()))
        arr.append(EventViewModel(event: Event()))
        arr.append(EventViewModel(event: Event()))
        arr.append(EventViewModel(event: Event()))
        events.value = arr
    }

}
