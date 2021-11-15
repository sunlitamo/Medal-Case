//
//  archCollectionViewCell.swift
//  Medal Case
//
//  Created by Fang Sun on 2021-11-13.
//

import UIKit

class ArchCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemValueLabel: UILabel!
    @IBOutlet weak var itemNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setData(image:String, name:String, value:String, isCompleted:Bool) {
        self.itemImage.image = UIImage(named: image)
        self.itemNameLabel.text = name
        self.itemValueLabel.text = value
        self.alpha = isCompleted ? 1.0 : 0.3
        self.contentView.alpha = isCompleted ? 1.0 : 0.3
    }

}
