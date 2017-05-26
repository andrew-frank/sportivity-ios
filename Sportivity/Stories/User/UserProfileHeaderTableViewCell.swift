//
//  UserHeaderTableViewCell.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 19/04/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class UserProfileHeaderTableViewCell: UITableViewCell, Configurable {

    @IBOutlet fileprivate weak var avatarImageVIew: UserAvatarImageView!
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var followersLabel: UILabel!
    @IBOutlet weak var actionButton: ActionButton!
    
    fileprivate var reuseBag = DisposeBag()
    
    var viewModel: UserProfileHeaderViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reuseBag = DisposeBag()
    }
    
    func configure(with viewModel: UserProfileHeaderViewModel) {
        viewModel
            .name
            .drive(nameLabel.rx.text)
            .addDisposableTo(reuseBag)
        
        viewModel
            .photoURL
            .driveNext { [unowned self] (url) in
                self.avatarImageVIew.kf.setImage(with: url)
            }
            .addDisposableTo(reuseBag)
        
        viewModel
            .followers
            .drive(followersLabel.rx.text)
            .addDisposableTo(reuseBag)
        
        viewModel
            .isItMe
            .map { $0 ? "EDIT" : "FOLLOW" }
            .drive(actionButton.rx.title())
            .addDisposableTo(reuseBag)
    }
}
