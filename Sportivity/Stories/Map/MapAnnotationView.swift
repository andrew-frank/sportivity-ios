//
//  MapAnnotationView.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 11/06/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import UIKit
import MapKit

class MapAnnotationView: MKAnnotationView {

    override open var annotation: MKAnnotation? {
        didSet {
//            configure()
        }
    }

//    public init(annotation: MKAnnotation?, reuseIdentifier: String?, type: ClusterAnnotationType) {
//        self.type = type
//        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
//    }
    
    private func configure() {
        
    }
}
