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
    fileprivate let userManager: UserManagerProtocol
    fileprivate let disposeBag = DisposeBag()
    
    let id: String
    let name: Driver<String>
    let photoUrl: Driver<URL?>
    let hostText: Driver<String>
    let placeName: Driver<String?>
    let placeLoc: Driver<Loc?>
    let street: Driver<String?>
    let city: Driver<String?>
    let attendees: Variable<[EventAttendee]>
    let isAttending = Variable<Bool>(false)
    
    let toggleAttend = PublishSubject<Void>()
    
    init(event: Event, userManager: UserManagerProtocol = UserManager()) {
        self.event = event
        self.id = event.id
        self.userManager = userManager
        
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
        self.attendees = event.attendees
        
        attendees
            .asObservable()
            .map { [unowned self] attendees -> Bool in
                guard let myId = self.userManager.user?.id else { return false }
                let isAttending = attendees.reduce(false, { (isAttending, attendee) -> Bool in
                    return isAttending || attendee.id == myId
                })
                return isAttending
            }
            .bind(to: isAttending)
            .addDisposableTo(disposeBag)
        
        bind()
    }
    
    private func bind() {
        toggleAttend
            .withLatestFrom(isAttending.asObservable())
            .doOnNext { (isAttending) in
                Logger.shared.log(.info, message: "toggleAttend from isAttending=\(isAttending) to \(!isAttending)")
            }
            .flatMap { [unowned self] (isAttending) -> Observable<Bool?> in
                if isAttending {
                    return EventsAPI.rx_leave(self.event.id).map { false }.catchErrorJustReturn(nil)
                } else {
                    return EventsAPI.rx_join(self.event.id).map { true }.catchErrorJustReturn(nil)
                }
            }
            .subscribeNext { [unowned self] (isAttending) in
                guard let isAttending = isAttending else {
                    return
                }
                guard let me = self.userManager.user else {
                    assert(false)
                    return
                }
                if isAttending {
                    let meAttendee = EventAttendee(user: me)
                    var newAttendees = self.attendees.value
                    newAttendees.append(meAttendee)
                    self.attendees.value = newAttendees
                } else {
                    let newAttendees = self.attendees.value.filter { $0.id != me.id }
                    self.attendees.value = newAttendees
                }
            }
            .addDisposableTo(disposeBag)
        
    }
}
