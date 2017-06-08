//
//  PlaceAPI.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 08/06/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import Foundation
import Alamofire

enum PlacesAPI {
    case fetchAll
}

extension PlacesAPI: NetworkHelpers {
    var baseURLString: String {
        return Config.APIBaseURL + "/places"
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchAll:
            return .get
        }
    }
    
    var relativePath: String? {
        switch self {
        case .fetchAll:
            return nil
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case .fetchAll:
            return nil
        }
    }
    
    var parametersEncoding: Alamofire.ParameterEncoding {
        switch self {
        case .fetchAll:
            return URLEncoding.queryString
        }
    }
}
