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
    
    let placeAnnotations = Variable<[MapAnnotation]>([ ])
    let disposeBag = DisposeBag()
    
    init() {
        fetch()
    }
    
    private func fetch() {
        PlacesAPI
            .rx_fetchAll()
            .catchErrorJustReturn([])
            .map({ (places) -> [MapAnnotation] in
                return places.map { return MapAnnotation(place: $0) }
            })
            .bind(to: placeAnnotations)
            .addDisposableTo(disposeBag)
    }
}
