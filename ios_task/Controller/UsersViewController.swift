//
//  ViewController.swift
//  ios task
//
//  Created by Hiba Malhis on 5/23/19.
//  Copyright © 2019 Hiba Malhis. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class UsersViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var usersTableView: UITableView!
    var usersDetails=[User]()
    
    let USERS_URL = "http://jsonplaceholder.typicode.com/users"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usersTableView.delegate=self
        usersTableView.dataSource=self
        usersTableView.register(UINib(nibName: "userCell", bundle: nil), forCellReuseIdentifier: "userCell")
        
        configureTableView()
        getUsersData()
        
    }
    
    func configureTableView() {
        usersTableView.rowHeight = UITableView.automaticDimension
        usersTableView.estimatedRowHeight = 120.0
    }
    
    func getUsersData(){
        Alamofire.request(USERS_URL).responseJSON { (response) in
            if response.result.isSuccess{
                let userDataJSON:JSON = JSON(response.result.value!)
                self.putDataIntoModel(json:userDataJSON)
            }else{
                self.showAlertMesage(title: "connection error ", msg: "\(response.result.error!)")
                print("connection error : \( response.result.error! )")
            }
        }
    }
    
    func putDataIntoModel(json usersData:JSON){
        usersDetails = usersData.map { (key,userDetails) in
            let user=User()
            user.id = userDetails["id"].intValue
            user.email=userDetails["email"].stringValue
            user.phone=userDetails["phone"].stringValue
            user.name=userDetails["name"].stringValue
            user.website=userDetails["website"].stringValue
            user.username=userDetails["username"].stringValue
            user.company.name=userDetails["company"]["name"].stringValue
            user.company.bs=userDetails["company"]["bs"].stringValue
            user.company.catchPhrase=userDetails["company"]["catchPhrase"].stringValue
            user.address.street=userDetails["address"]["street"].stringValue
            user.address.suite=userDetails["address"]["suite"].stringValue
            user.address.city=userDetails["address"]["city"].stringValue
            user.address.zipcode=userDetails["address"]["zipcode"].stringValue
            user.address.geo["lat"]=userDetails["address"]["geo"]["lat"].stringValue
            user.address.geo["lng"]=userDetails["address"]["geo"]["lng"].stringValue
            return user
            
        }
        usersTableView.reloadData()
        configureTableView()
    }
    
    func showAlertMesage(title:String,msg:String){
        let alert = UIAlertController(title: title , message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="moveToUserDetails"{
            let dest = segue.destination as! UserDetailsViewController
            let indexPath = usersTableView.indexPathForSelectedRow
            dest.userDetails=self.usersDetails[(indexPath?.row)!]
            
        }
    }
    
}

extension UsersViewController{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersDetails.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell=tableView.dequeueReusableCell(withIdentifier: "userCell") as! userCell
        cell.name.text = usersDetails[indexPath.row].name
        cell.email.text = usersDetails[indexPath.row].email
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "moveToUserDetails", sender: self)
        
    }
    
}

