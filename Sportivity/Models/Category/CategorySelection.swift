//
//  CategorySelection.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 19/04/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import Foundation
import RxSwift

struct CategorySelection {
    let category : Category
    let isSelected = Variable<Bool>(false)
    
    init(category: Category, isSelected: Bool = false) {
        self.category = category
        self.isSelected.value = isSelected
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
