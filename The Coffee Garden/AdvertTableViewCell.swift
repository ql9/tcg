//
//  AdvertTableViewCell.swift
//  The Coffee Garden
//
//  Created by Quốc Lê on 8/31/20.
//  Copyright © 2020 Quốc Lê. All rights reserved.
//

import UIKit

protocol AdvertTableViewCellDelegate: AnyObject {
    func didTapButton(with title: String)
}

class AdvertTableViewCell: UITableViewCell {
    
    weak var delegate: AdvertTableViewCellDelegate?
    
    static let indentifier = "AdvertTableViewCell"
    
    static func nib() -> UINib{
        return UINib(nibName: "AdvertTableViewCell", bundle: nil)
    }
    
    @IBOutlet var button: UIButton!
    private var title: String = ""
    
    @IBAction func didTapButton(){
        delegate?.didTapButton(with: title)
    }
    
    func configure(with title: String){
        self.title = title
        button.setTitle(title, for: .normal)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        button.setTitleColor(.link, for: .normal)
    }
}
