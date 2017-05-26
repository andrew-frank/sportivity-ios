//
//  CategoriesSelectionViewModel.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 26/05/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CategoriesSelectionViewModel {
    let selections: Variable<[CategorySelection]>
    
    init(selections: Variable<[CategorySelection]>) {
        self.selections = selections
    }
}
