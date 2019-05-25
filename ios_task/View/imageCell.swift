//
//  imageCell.swift
//  ios_task
//
//  Created by Hiba Malhis on 5/24/19.
//  Copyright © 2019 Hiba Malhis. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class imageCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var title: UITextView!
    
    func updateUi(){

        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.cornerRadius = 10
        title.isEditable = false
        
    }
    
}
