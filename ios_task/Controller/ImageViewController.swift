//
//  ImageViewController.swift
//  ios_task
//
//  Created by Hiba Malhis on 5/25/19.
//  Copyright © 2019 Hiba Malhis. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ImageViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    var imageURL:String?{
        didSet{
            updateUi()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func updateUi(){
        if let url = imageURL{
            Alamofire.request(url).responseImage { (response) in
                if response.result.isSuccess{
                    self.imageView.image = response.result.value
                }else{
                    self.showAlertMesage(title: "connection error ", msg: "\(response.result.error!)")
                    print("connection error :\(response.result.error!)")
                }
            }
            
        }
    }
    
    func showAlertMesage(title:String,msg:String){
        let alert = UIAlertController(title: title , message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    
  
    
}
