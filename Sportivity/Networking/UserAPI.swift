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
    case search(name: String?)
}

extension UserAPI: NetworkHelpers {
    var baseURLString: String {
        return Config.APIBaseURL + "/users"
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetch, .search:
            return .get
        }
    }
    
    var relativePath: String? {
        switch self {
        case .fetch(let id):
            return "/\(id)"
        case .search:
            return nil
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case .fetch:
            return nil
        case .search(let name):
            var params = Alamofire.Parameters.init()
            if let name = name {
                params["name"] = name
            }
            return params
        }
    }
    
    var parametersEncoding: Alamofire.ParameterEncoding {
        switch self {
        case .fetch, .search:
            return URLEncoding.queryString
        }
    }
}
