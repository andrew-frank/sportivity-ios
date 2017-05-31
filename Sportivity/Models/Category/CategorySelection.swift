//
//  CategorySelection.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 19/04/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class CategorySelections {
    
    private let _selections: Variable<[String: Bool]>
    let rx_selections: Driver<[String: Bool]>
    var selections: [String: Bool] {
        return _selections.value
    }
    let select = PublishSubject<String>()
    let deselect = PublishSubject<String>()
    let disposeBag = DisposeBag()
    
    var selectedCategories: [Category] {
        let selectedKeys = _selections.value.filter { return $1 }.map { (key: String, value: Bool) -> String in
            return key
        }
        let categories = selectedKeys.map { Category(rawValue: $0) }
        return categories.filter { $0 != nil }.map { $0! }
    }
    
    init(selected: [Category]?) {
        
        let userCategories = selected ?? [Category]()
        var selectionsDict = [String: Bool]()
        let all = Category.all()
        
        for category in all {
            selectionsDict[category.rawValue] = false
            for selection in userCategories {
                if selection.rawValue == category.rawValue {
                    selectionsDict[category.rawValue] = true
                    break
                }
            }
        }
        
        _selections = Variable<[String: Bool]>(selectionsDict)
        rx_selections = _selections.asDriver()
        select.asObservable().subscribeNext { [weak self] (category) in
            self?.set(category: category, selected: true)
        }
        .addDisposableTo(disposeBag)
        deselect.asObservable().subscribeNext { [weak self] (category) in
            self?.set(category: category, selected: false)
        }
        .addDisposableTo(disposeBag)
    }
    
    func set(category: String, selected: Bool) {
        var selections = _selections.value
        selections[category] = selected
        _selections.value = selections
    }
}

////

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
