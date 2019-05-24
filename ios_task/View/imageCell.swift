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
    
    var cellDetails:image?{
        didSet{
            updateUi()
        }
    }
    
    func updateUi(){
        if let cellDetails = cellDetails{
            title.text = cellDetails.title
            Alamofire.request(cellDetails.thumbnailUrl).responseImage { (response) in
                if response.result.isSuccess{
                    self.thumbnailImage.image=response.result.value
                }else{
                    
                    print("connection error")
                }
            }
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.cornerRadius = 10
        title.isEditable = false
        
    }
    
}
