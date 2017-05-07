//
//  GamesViewModel.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 18/04/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class EventsViewModel {
    let events = Variable<[EventViewModel]>([ ])
    let categories = Variable<[CategorySelection]>(CategorySelection.all())
    
    init() {
        var arr = [EventViewModel]()
        arr.append(EventViewModel(event: Event()))
        arr.append(EventViewModel(event: Event()))
        arr.append(EventViewModel(event: Event()))
        arr.append(EventViewModel(event: Event()))
        arr.append(EventViewModel(event: Event()))
        arr.append(EventViewModel(event: Event()))
        events.value = arr
    }
}
