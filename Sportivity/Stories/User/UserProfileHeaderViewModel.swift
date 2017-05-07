//
//  UserHeaderViewModel.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 19/04/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import Foundation
import RxSwift

class UserProfileHeaderViewModel {
    let name : Observable<String> = Observable.just("Andrew Frank")
    let followesLine : Observable<String> = Observable.just("12 Followers / 8 Following")
}
