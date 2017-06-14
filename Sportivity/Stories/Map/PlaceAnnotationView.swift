//
//  PlaceAnnotationView.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 11/06/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import UIKit
import MapKit

class PlaceAnnotationView: MKPinAnnotationView {

    override open var annotation: MKAnnotation? {
        didSet {
            configure()
        }
    }

    private func configure() {
        guard let annotation = annotation as? MapAnnotation else { return }
        
        
    }
}
