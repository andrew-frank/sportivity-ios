//
//  Event.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 18/04/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import Foundation
import RxSwift

struct Event {
    let name : Variable<String>
    
    init(name: String = "Event default name") {
        self.name = Variable<String>(name)
    }
}
