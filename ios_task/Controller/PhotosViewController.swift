//
//  PhotosViewController.swift
//  ios_task
//
//  Created by Hiba Malhis on 5/24/19.
//  Copyright © 2019 Hiba Malhis. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage


class PhotosViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    let IMAGES_DATA_URL = "http://jsonplaceholder.typicode.com/photos"
    
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    @IBOutlet weak var photosCollectionView: UICollectionView!
    
    
    var imagessDetails=[image]()
    var albums=[Int:[image]]() //key is section_id , value: array of images in section
    var sortedAlbums = [(key: Int, value: [image])]()
    
    var selectedImage=image()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photosCollectionView.delegate=self
        photosCollectionView.dataSource=self
        photosCollectionView.register(UINib(nibName: "imageCell", bundle: nil), forCellWithReuseIdentifier: "imageCell")
        
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        let cellWidth=(self.view.frame.size.width-20)/2
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        
        getPhotosData()
        
    }
    
    
    
    
    func getPhotosData(){
        Alamofire.request(IMAGES_DATA_URL).responseJSON { (response) in
            if response.result.isSuccess{
                let imagesDataJSON:JSON = JSON(response.result.value!)
                self.updateUI(json:imagesDataJSON)
            }else{
                self.showAlertMesage(title: "connection error ", msg: "\(response.result.error!)")
                print("connection error :\(response.result.error!)")
            }
        }
    }
    
    func showAlertMesage(title:String,msg:String){
        let alert = UIAlertController(title: title , message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    func updateUI(json imagesData:JSON){
        
        imagessDetails = imagesData.map { (key,imageDetails) in
            
            let img = image()
            img.albumId=imageDetails["albumId"].intValue
            img.id=imageDetails["id"].intValue
            img.title=imageDetails["title"].stringValue
            img.url=imageDetails["url"].stringValue
            img.thumbnailUrl=imageDetails["thumbnailUrl"].stringValue
            
            //add image to album
            if albums[img.albumId] != nil {
                albums[img.albumId]?.append(img)
            }else{
                albums[img.albumId] = [image]()
                albums[img.albumId]?.append(img)
            }
            
            return img
        }
        
        
        sortedAlbums = albums.sorted { $0.key <  $1.key }
        
        photosCollectionView.reloadData()
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="showImage"{
            let dest = segue.destination as! ImageViewController
            dest.imageURL=selectedImage.url
        }
    }
    
    
}

extension PhotosViewController{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sortedAlbums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sortedAlbums[section].value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let img:image = sortedAlbums[indexPath.section].value[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! imageCell
        
        
        cell.title.text = img.title
        Alamofire.request(img.thumbnailUrl).responseImage { (response) in
            if response.result.isSuccess{
                cell.thumbnailImage.image=response.result.value
            }else{
                
                print("connection error")
            }
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerView", for: indexPath) as! ImagesHeaderView
        headerCell.sectionTitle.text = "\(sortedAlbums[indexPath.section].key)"
        return headerCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedImage = sortedAlbums[indexPath.section].value[indexPath.row]
        performSegue(withIdentifier: "showImage", sender: self)
    }
    
    
}

