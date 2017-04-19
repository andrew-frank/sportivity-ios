//
//  EventAPI.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 19/04/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import Foundation
//import Alamofire
//
//enum EventsAPI {
//    //case getOne(id: String)
//    case getEvents(parameters: [String : Any]?)
//    //case create(parameters: [String : Any])
//    //case update(id: String, parameters: [String : Any])
//}
//
//extension EventsAPI: NetworkHelpers {
//    var baseURLString: String {
//        return Config.sharedInstance.APIBaseURL + "/event"
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
