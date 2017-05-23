//
//  User.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 21/05/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import Foundation
import Unbox
import RxSwift

struct User: Unboxable {
    
    let id: String
    let email = Variable<String>("")
    let name = Variable<String>("")
    let city = Variable<String?>(nil)
    let photoUrl = Variable<URL?>(nil)
    let sportsCategories = Variable<[String]>([ ])
    let token : String?
    
    init(unboxer: Unboxer) throws {
        id = try unboxer.unbox(key: "_id")
        email.value = try unboxer.unbox(key: "email")
        name.value = try unboxer.unbox(key: "name")
        city.value = unboxer.unbox(key: "city")
        photoUrl.value = unboxer.unbox(key: "photoUrl")
        sportsCategories.value = try unboxer.unbox(key: "sportsCategories")
        token = unboxer.unbox(key: "token")
    }
}
