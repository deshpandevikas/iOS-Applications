//
//  DetailPhotoViewController.swift
//  InClass07
//
//  Created by Deshpande, Vikas on 10/26/17.
//  Copyright © 2017 Sai Nishanth Dilly. All rights reserved.
//

import UIKit
import Firebase

class DetailPhotoViewController: UIViewController {
    var url = ""
    var key = ""
    
    let firebaseImagesRef = Storage.storage().reference().child("Images");
    let reference = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            putImage()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deleteImage(_ sender: UIBarButtonItem)
    {
        
        let alert = UIAlertController(title: "Photo Delete", message: "Are you sure you want to delete this photo?", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            
            let key1 : String = self.key + ".png"
            
            self.firebaseImagesRef.child(key1).delete{ error in
                if let error = error {
                    
                    print(error)
                    
                } else {
                    
                    self.reference.child("Images").child((Auth.auth().currentUser?.uid)!).child(self.key).removeValue()
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let photosCollection = storyboard.instantiateViewController(withIdentifier: "photosCollection") as! UINavigationController
                    self.present(photosCollection, animated: true, completion: nil)
                    
                }
            }
            
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            
            self.dismiss(animated: true, completion: nil)
            
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    func putImage()  {
        
        image.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "add.png"))
    }
    
    @IBOutlet weak var image: UIImageView!
    
   
}
