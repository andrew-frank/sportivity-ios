//
//  UserAPI.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 21/05/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import Foundation
//import Alamofire
//
//enum UserAPI {
//    case getEvents(parameters: [String : Any]?)
//}
//
//extension UserAPI: NetworkHelpers {
//    var baseURLString: String {
//        return Config.sharedInstance.APIBaseURL + "/user"
//    }
//    
//    var method: Alamofire.HTTPMethod {
//        switch self {
//        case .getEvents:
//            return .get
//        }
//    }
//    
//    var relativePath: String? {
//        switch self {
//        case .getEvents:
//            return nil
//        }
//    }
//    
//    var parameters: Alamofire.Parameters? {
//        switch self {
//        case .getEvents(let params):
//            return params
//        }
//    }
//    
//    var parametersEncoding: Alamofire.ParameterEncoding {
//        switch self {
//        case .getEvents:
//            return URLEncoding.queryString
//        }
//    }
//}