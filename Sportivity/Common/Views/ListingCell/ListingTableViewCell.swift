//
//  ListingTableViewCell.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 19/04/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import UIKit
import RxSwift

class ListingTableViewCell: UITableViewCell, Configurable {
    
    @IBOutlet fileprivate weak var avatarImageView: AvatarImageView!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    
    var viewModel: ListingViewModelProtocol!
    
    fileprivate var reuseBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reuseBag = DisposeBag()
    }
    
    func set(viewModel: ListingViewModelProtocol) {
        self.viewModel = viewModel
        // TODO: configure
    }
    
    func configure() {
        viewModel.title.drive(titleLabel.rx.text).addDisposableTo(reuseBag)
        viewModel.imageUrl
            .driveNext { [unowned self] (url) in
                guard let url = url else { return }
                self.avatarImageView.kf.setImage(with: url)
            }
            .addDisposableTo(reuseBag)
    }
}
