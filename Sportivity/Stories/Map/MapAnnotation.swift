//
//  MapAnnotation.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 11/06/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import UIKit
import MapKit

enum MapAnnotationType {
    case pin(image: UIImage)
    case cluster(annotations: [MKAnnotation])
}

class MapAnnotation: NSObject, MKAnnotation {
    // Center latitude and longitude of the annotation view.
    // The implementation of this property must be KVO compliant.
    var coordinate = CLLocationCoordinate2D()
    // Title and subtitle for use by selection UI.
    var title: String?
    var subtitle: String?
    var type: MapAnnotationType
    
    init(type: MapAnnotationType) {
        self.type = type
    }
}
