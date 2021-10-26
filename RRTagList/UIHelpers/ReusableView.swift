//
//  ReusableView.swift
//  RRTagList
//
//  Created by Raj Rathod on 26/10/21.
//

import UIKit

class ReusableView: UICollectionReusableView {
   @IBOutlet var tagHeaderLabel: UILabel!
}

class CustomButton: UIButton {
    var section: Int = 0
    var row : Int = 0
}
