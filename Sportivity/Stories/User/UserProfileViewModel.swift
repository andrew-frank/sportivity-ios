//
//  UserViewModel.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 19/04/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class UserProfileViewModel {
    
    let cellsData = Variable<[Any]>([ ])
    let isItMe: Driver<Bool>
    
    init(user: User, userManager: UserManagerProtocol = UserManager.shared) {
        isItMe = Driver<Bool>.just(userManager.user?.id == user.id)
        
        var cells = [Any]()
        let header = UserProfileHeaderViewModel(user: user, isItMe: isItMe)
        cells.append(header)
        for event in user.events.value {
            cells.append(EventViewModel(event: event))
        }
        cellsData.value = cells
    }
}
