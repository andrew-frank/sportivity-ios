//
//  EventProfileHeaderViewModel.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 25/05/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class EventProfileHeaderViewModel {
    fileprivate let event: Event
    
    let name: Driver<String>
    let photoUrl: Driver<URL?>
    let hostText: Driver<String>
    let placeName: Driver<String>
    let placeLoc: Driver<Loc?>
    let street: Driver<String?>
    let city: Driver<String?>
    
    init(event: Event) {
        self.event = event
        self.name = event.name.asDriver()
        let placePhotos = event.place.asDriver().map { (place) -> [URL] in
            return place.photosURL.value ?? [URL]()
        }
        self.photoUrl = Driver.combineLatest(event.photoUrl.asDriver(), placePhotos, resultSelector: { (eventPhoto, placePhotos) in
            return eventPhoto ?? placePhotos.first
        })
        let hostText: Observable<String> = event.host.asObservable()
            .flatMap({ (user) -> Observable<String> in
                return user.name.asObservable()
            })
            .map { (name) -> String in
                return "Organised by: \(name)"
            }
        self.placeName = event.place.asDriver().map { $0.name.value }
        self.placeLoc = event.place.asDriver().map { $0.loc.value }
        self.street = event.place.asDriver().map { $0.street.value }
        self.city = event.place.asDriver().map { $0.city.value }
        self.hostText = hostText.asDriver(onErrorJustReturn: "")
    }
}
