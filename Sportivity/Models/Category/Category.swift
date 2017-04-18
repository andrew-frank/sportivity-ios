//
//  Category.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 18/04/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import Foundation

struct Category {
    let name : String
    let selected : Bool
    
    init(name: String, selected: Bool = false) {
        self.name = name
        self.selected = selected
    }
}

extension Category {
    static func all() -> [Category] {
        var all = [Category]()
        all.append(Category(name: "Football"))
        all.append(Category(name: "Football"))
        all.append(Category(name: "Football"))
        all.append(Category(name: "Football"))
        all.append(Category(name: "Football"))
        return all
    }
}
