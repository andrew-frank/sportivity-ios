//
//  BorderedClusterAnnotationView.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 11/06/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import UIKit
import MapKit

class OutlinedClusterAnnotationView: ClusterAnnotationView {
    var outlineColor: UIColor?
    
    convenience init(annotation: MKAnnotation?, reuseIdentifier: String?, type: ClusterAnnotationType, outlineColor: UIColor) {
        self.init(annotation: annotation, reuseIdentifier: reuseIdentifier, type: type)
        self.outlineColor = borderColor
    }
    
    override func configure() {
        super.configure()
        
        switch type {
        case .image:
            break
        case .color:
            layer.borderColor = outlineColor?.cgColor
            layer.borderWidth = 2
        }
    }
}
