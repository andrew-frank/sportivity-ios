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
    let categories = Variable<[Category]>(Category.all())
    
    init() {
        var arr = [EventViewModel]()
        arr.append(EventViewModel())
        arr.append(EventViewModel())
        arr.append(EventViewModel())
        arr.append(EventViewModel())
        arr.append(EventViewModel())
        events.value = arr
    }
}
