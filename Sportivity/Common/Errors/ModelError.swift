//
//  ModelError.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 21/05/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import Foundation

enum ModelError: Error {
    
    case serializationError(response: HTTPURLResponse?)
    case mappingError(error: Error, type: Any)
    case wrappingError(error: Error, type: Any)
    case socketSerializationError
    case validationError(message: String)
    
    var description: String {
        switch self {
        case .validationError(let message):
            return message
        default:
            return self.defaultMessage
        }
    }
}
