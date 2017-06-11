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
    var type: ClusterAnnotationType?
}

class ClusterAnnotation: Annotation {
    var annotations = [MKAnnotation]()
}

enum ClusterAnnotationType {
    case color(UIColor, radius: CGFloat)
    case image(UIImage?)
}

class ClusterAnnotationView: MKAnnotationView {
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.backgroundColor = .clear
        label.font = .boldSystemFont(ofSize: 13)
        label.textColor = .white
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 2
        label.baselineAdjustment = .alignCenters
        self.addSubview(label)
        return label
    }()
    
    override var annotation: MKAnnotation? {
        didSet {
            configure()
        }
    }
    
    let type: ClusterAnnotationType
    
    public init(annotation: MKAnnotation?, reuseIdentifier: String?, type: ClusterAnnotationType) {
        self.type = type
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        guard let annotation = annotation as? ClusterAnnotation else { return }
        
        switch type {
        case let .image(image):
            backgroundColor = .clear
            self.image = image
        case let .color(color, radius):
            let count = annotation.annotations.count
            backgroundColor	= color
            var diameter = radius * 2
            switch count {
            case _ where count < 8:
                diameter *= 0.6
            case _ where count < 16:
                diameter *= 0.8
            default: break
            }
            frame = CGRect(origin: frame.origin, size: CGSize(width: diameter, height: diameter))
            countLabel.text = "\(count)"
        }
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if case .color = type {
            layer.masksToBounds = true
            layer.cornerRadius = image == nil ? bounds.width / 2 : 0
            countLabel.frame = bounds
        }
    }
    
}
