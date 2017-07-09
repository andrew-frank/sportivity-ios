//
//  PlacesAPI+Requests.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 08/06/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import Foundation
import RxSwift

extension PlacesAPI {
    static func rx_fetchAll() -> Observable<[Place]> {
        return PlacesAPI
            .fetchAll
            .validatedRequest()
            .rx_responseModelsArray(Place.self)
    }
    
    static func rx_fetchPlace(id: String) -> Observable<Place> {
        return PlacesAPI
            .fetchPlace(id: id)
            .validatedRequest()
            .rx_responseModel(Place.self)
    }
}
