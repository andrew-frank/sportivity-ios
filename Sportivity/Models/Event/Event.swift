//
//  Event.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 18/04/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import Foundation
import RxSwift
import Unbox

struct Event : Unboxable {
    let id: String
    let name: Variable<String>
    
    init(name: String = "Event default name") {
        self.id = "0"
        self.name = Variable<String>(name)
    }
    
    init(unboxer: Unboxer) throws {
        self.id = try unboxer.unbox(key: "_id")
        let name : String = try unboxer.unbox(key: "name")
        self.name = Variable<String>(name)
    }
}
