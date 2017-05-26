//
//  UserAPI.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 21/05/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import Foundation
import Alamofire

enum UserAPI {
    case fetch(user: String)
}

extension UserAPI: NetworkHelpers {
    var baseURLString: String {
        return Config.APIBaseURL + "/users"
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetch:
            return .get
        }
    }
    
    var relativePath: String? {
        switch self {
        case .fetch(let id):
            return "/\(id)"
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case .fetch:
            return nil
        }
    }
    
    var parametersEncoding: Alamofire.ParameterEncoding {
        switch self {
        case .fetch:
            return URLEncoding.queryString
        }
    }
}
