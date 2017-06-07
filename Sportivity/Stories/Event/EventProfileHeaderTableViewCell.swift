//
//  EventProfileHeaderTableViewCell.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 25/05/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import UIKit
import MapKit
import RxSwift
import Kingfisher

class EventProfileHeaderTableViewCell: UITableViewCell, Configurable {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var hostLabel: UILabel!
    @IBOutlet weak var attendButton: ActionButton!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var reuseBag = DisposeBag()
    private let disposeBag = DisposeBag()
    
    var viewModel: EventProfileHeaderViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
        viewModel.hostText.drive(hostLabel.rx.text).addDisposableTo(reuseBag)
        viewModel.placeName.drive(placeNameLabel.rx.text).addDisposableTo(reuseBag)
        viewModel.street.drive(addressLabel.rx.text).addDisposableTo(reuseBag)
        viewModel.city.drive(cityLabel.rx.text).addDisposableTo(reuseBag)

        viewModel
            .isAttending
            .asObservable()
            .subscribeNext { [unowned self] (isAttending) in
                if isAttending {
                    self.attendButton.setTitle("LEAVE", for: .normal)
                } else {
                    self.attendButton.setTitle("JOIN", for: .normal)
                }
            }
            .addDisposableTo(reuseBag)

        attendButton
            .rx.tap
            .asObservable()
            .subscribeNext { [unowned self] () in
                self.viewModel.toggleAttend.onNext()
            }
            .addDisposableTo(disposeBag)
    }
}
