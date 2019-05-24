//
//  User.swift
//  ios task
//
//  Created by Hiba Malhis on 5/23/19.
//  Copyright © 2019 Hiba Malhis. All rights reserved.
//

import Foundation

class Address {
    
    var street: String = " "
    var suite: String = " "
    var city: String = " "
    var zipcode: String = " "
    var geo = ["lat":"","lng":""]
}

class Company {
    
    var name:String = " "
    var catchPhrase:String = " "
    var bs:String = " "
}

class User {
    
    var id: Int = 0
    var name: String  = " "
    var username: String  = " "
    var email: String  = " "
    
    var address=Address()
    var phone: String = " "
    var website: String = " "
    var company=Company()
    
    
}
