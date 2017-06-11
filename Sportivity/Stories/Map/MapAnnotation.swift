//
//  MapAnnotation.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 11/06/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import Foundation
import MapKit

enum MapAnnotationType {
    case pin
    case cluster
}

class MapAnnotation: NSObject, MKAnnotation {
    // Center latitude and longitude of the annotation view.
    // The implementation of this property must be KVO compliant.
    var coordinate = CLLocationCoordinate2D()
    // Title and subtitle for use by selection UI.
    var title: String?
    var subtitle: String?
    var type = MapAnnotationType.pin
    
    init(place: Place) {
        if let lat = place.loc.value?.lat, let lon = place.loc.value?.lon {
            coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        }
        title = place.name.value
    }
    
    init(type: MapAnnotationType) {
        self.type = type
    }
}
