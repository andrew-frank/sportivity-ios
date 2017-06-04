
//
//  EventViewModel.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 18/04/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import Foundation
import RxDataSources
import RxSwift
import RxCocoa

class EventViewModel : IdentifiableType, Equatable {
    
    let event: Event
    
    typealias Identity = String
    let identityID: String = UUID().uuidString
    var identity: String {
        return identityID
    }
    
    let name: Driver<String>
    let photoUrl: Driver<URL?>

    init(event: Event) {
        self.event = event
        name = event.name.asDriver()
        let placePhoto = event.place.asDriver().flatMap { (place) -> Driver<URL?> in
            guard let place = place else {
                return Driver<URL?>.just(nil)
            }
            return place.photoURL.asDriver()
        }
        let eventPhoto = event.photoUrl.asDriver()
        photoUrl = Driver.combineLatest(eventPhoto, placePhoto, resultSelector: { (eventPhoto, placePhoto) in
            return eventPhoto ?? placePhoto
        })
    }
}
