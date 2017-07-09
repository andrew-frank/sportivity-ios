//
//  PlaceProfileHeaderTableViewCell.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 09/07/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import UIKit
import MapKit
import RxSwift
import Kingfisher

class PlaceProfileHeaderTableViewCell: UITableViewCell, Configurable {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var reuseBag = DisposeBag()
    private let disposeBag = DisposeBag()
    
    var viewModel: PlaceProfileHeaderViewModel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reuseBag = DisposeBag()
    }
    
    func configure() {
        viewModel.name.drive(nameLabel.rx.text).addDisposableTo(reuseBag)
        viewModel
            .photoUrl
            .driveNext { [unowned self] (url) in
                self.photoImageView.kf.setImage(with: url)
            }
            .addDisposableTo(reuseBag)
        viewModel.street.drive(addressLabel.rx.text).addDisposableTo(reuseBag)
        viewModel.city.drive(cityLabel.rx.text).addDisposableTo(reuseBag)
    }
}
