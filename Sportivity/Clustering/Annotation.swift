//
//  Annotation.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 11/06/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import MapKit

class Annotation: NSObject, MKAnnotation {
    var coordinate = CLLocationCoordinate2D()
    var title: String?
    var subtitle: String?
}

class ClusterAnnotation: Annotation {
    var annotations = [MKAnnotation]()
}

struct ClusterAnnotationViewConstants {
    static let radius = 25.0
    static let outlineColor = UIColor.white
}
