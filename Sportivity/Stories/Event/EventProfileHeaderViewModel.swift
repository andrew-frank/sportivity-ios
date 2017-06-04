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
    let placeName: Driver<String?>
    let placeLoc: Driver<Loc?>
    let street: Driver<String?>
    let city: Driver<String?>
    
    init(event: Event) {
        self.event = event
        self.name = event.name.asDriver()
//        let placePhoto = event.place.asDriver().flatMap { (place) -> Driver<URL?> in
//            guard let place = place else {
//                return Driver<URL?>.just(nil)
//            }
//            return place.photoURL.asDriver()
//        }
//        let eventPhoto = event.photoUrl.asDriver()
//        photoUrl = Driver.combineLatest(eventPhoto, placePhoto, resultSelector: { (eventPhoto, placePhoto) in
//            return eventPhoto ?? placePhoto
//        })
        photoUrl = event.place.asDriver().map { $0?.photoURL.value }
        let hostText: Observable<String> = event.host.asObservable()
            .flatMap({ (user) -> Observable<String> in
                guard let user = user else { return Observable.just("") }
                return user.name.asObservable()
            })
            .map { (name) -> String in
                return "Organised by: \(name)"
            }
        self.placeName = event.place.asDriver().map { $0?.name.value }
        self.placeLoc = event.place.asDriver().map { $0?.loc.value }
        self.street = event.place.asDriver().map { $0?.street.value }
        self.city = event.place.asDriver().map { $0?.city.value }
        self.hostText = hostText.asDriver(onErrorJustReturn: "")
    }
}
