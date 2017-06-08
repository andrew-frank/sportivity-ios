//
//  MapViewModel.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 08/06/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MapViewModel {
    
    let pins = Variable<[Place]>([ ])
    let disposeBag = DisposeBag()
    
    init() {
        fetch()
    }
    
    private func fetch() {
        PlacesAPI
            .rx_fetchAll()
            .catchErrorJustReturn([])
            .bind(to: pins)
            .addDisposableTo(disposeBag)
    }
}
