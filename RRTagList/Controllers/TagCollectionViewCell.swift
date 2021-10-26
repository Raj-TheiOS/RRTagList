//
//  TagCollectionViewCell.swift
//  RRTagList
//
//  Created by Raj Rathod on 26/10/21.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    @IBOutlet var tagLabel: UILabel!
    @IBOutlet weak var deleteButton: CustomButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = (tagLabel.frame.size.height / 2.0)-5
//        self.backgroundColor = .white
//        self.tagLabel.textColor = .n
    }
}
