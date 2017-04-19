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

class UserHeaderTableViewCell: UITableViewCell {

    @IBOutlet fileprivate weak var avatarImageVIew: UserAvatarImageView!
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var followersLabel: UILabel!
    
    fileprivate var reuseBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reuseBag = DisposeBag()
    }
    
    func configure(with viewModel: UserHeaderViewModel) {
        viewModel
            .name
            .bind(to: nameLabel.rx.text)
            .addDisposableTo(reuseBag)
        
        viewModel
            .followesLine
            .bind(to: followersLabel.rx.text)
            .addDisposableTo(reuseBag)
    }
}
