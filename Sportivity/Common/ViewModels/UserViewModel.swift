//
//  UserViewModel.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 25/05/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class UserViewModel: UserRouteData {
    
    let id: String
    typealias Identity = String
    let identityID: String = UUID().uuidString
    var identity: String {
        return identityID
    }
    
    let name: Driver<String>
    let photoUrl: Driver<URL?>
    
    init(user: User) {
        self.id = user.id
        name = user.name.asDriver()
        photoUrl = user.photoUrl.asDriver()
    }
    
    init(attendee: EventAttendee) {
        self.id = attendee.id
        name = attendee.name.asDriver()
        photoUrl = attendee.photoUrl.asDriver()
    }
}
