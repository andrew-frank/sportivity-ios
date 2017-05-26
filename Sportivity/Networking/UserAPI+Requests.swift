//
//  UserAPI+Requests.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 21/05/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import Foundation
import RxSwift
import Wrap
import Result

extension UserAPI {
    static func rx_fetchUser(_ id: String) -> Observable<Result<User, APIError>> {
        return UserAPI
            .fetch(user: id)
            .validatedRequest()
            .rx_responseModel(User.self)
            .resultifyAPIResponse()
    }
}
