//
//  UserDetailsTableViewController.swift
//  ios_task
//
//  Created by Hiba Malhis on 5/24/19.
//  Copyright © 2019 Hiba Malhis. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var website: UILabel!
    @IBOutlet weak var street: UILabel!
    @IBOutlet weak var suite: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var zipcode: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var catchPhrase: UILabel!
    @IBOutlet weak var bs: UILabel!
    @IBOutlet weak var lat: UILabel!
    @IBOutlet weak var lng: UILabel!
    
    
    var userDetails:User?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI(){
        if let userDetails = userDetails{
            userName.text = userDetails.name
            email.text = userDetails.email
            phone.text = userDetails.phone
            website.text = userDetails.website
            street.text = userDetails.address.street
            suite.text = userDetails.address.suite
            city.text = userDetails.address.city
            zipcode.text = userDetails.address.zipcode
            companyName.text = userDetails.company.name
            catchPhrase.text = userDetails.company.catchPhrase
            bs.text = userDetails.company.bs
            lat.text = userDetails.address.geo["lat"]
            lng.text = userDetails.address.geo["lng"]
        }
        
        
    }
    
    
    
}
