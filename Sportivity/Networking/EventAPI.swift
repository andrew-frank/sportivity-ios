//
//  EventAPI.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 19/04/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import Foundation
import Alamofire

enum EventsAPI {
    case fetchEvent(id: String)
    case fetchEvents(parameters: [String : Any]?)
    //case create(parameters: [String : Any])
    //case update(id: String, parameters: [String : Any])
}

extension EventsAPI: NetworkHelpers {
    var baseURLString: String {
        return Config.APIBaseURL + "/events"
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchEvent, .fetchEvents:
            return .get
        }
    }
    
    var relativePath: String? {
        switch self {
        case .fetchEvent(let id):
            return "/\(id)"
        case .fetchEvents:
            return nil
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case .fetchEvent:
            return nil
        case .fetchEvents(let params):
            return params
        }
    }
    
    var parametersEncoding: Alamofire.ParameterEncoding {
        switch self {
        case .fetchEvent, .fetchEvents:
            return URLEncoding.queryString
        }
    }
}
