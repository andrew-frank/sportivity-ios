//
//  CategorySelection.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 19/04/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import Foundation

struct CategorySelection {
    let category : Category
    let selected : Bool
    
    init(category: Category, selected: Bool = false) {
        self.category = category
        self.selected = selected
    }
}

extension CategorySelection {
    static func all() -> [CategorySelection] {
        var all = [CategorySelection]()
        let allCategories = Category.all()
        for category in allCategories {
            all.append(CategorySelection(category: category))
        }
        return all
    }
}
