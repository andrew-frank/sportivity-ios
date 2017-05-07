//
//  EventTableViewCell.swift
//  Sportivity
//
//  Created by Andrzej Frankowski on 07/05/2017.
//  Copyright © 2017 Sportivity. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class EventTableViewCell: UITableViewCell, Configurable {

    fileprivate var reuseBag = DisposeBag()

    @IBOutlet fileprivate weak var photoImageView: UIImageView!
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    
    var viewModel: EventViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reuseBag = DisposeBag()
    }
    
    func configure(with viewModel: EventViewModel) {
        viewModel
            .name
            .asDriver()
            .drive(nameLabel.rx.text)
            .addDisposableTo(reuseBag)
    }
}
