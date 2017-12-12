//
//  PhotosCollectionViewController.swift
//  InClass07
//
//  Created by Deshpande, Vikas on 10/26/17.
//  Copyright © 2017 Sai Nishanth Dilly. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

private let reuseIdentifier = "cell"

class PhotosCollectionViewController: UICollectionViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UICollectionViewDelegateFlowLayout {
    
    let fetchReference = Database.database().reference().child("Images").child((Auth.auth().currentUser?.uid)!)
    
    var firebaseReference = Storage.storage().reference()
    let rootRef = Database.database().reference()
    var list = [String] ()
    var keys = [String] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Bandini")
       // retriveImagesFromFirebase()
       // self.collectionView?.delegate = self
        //self.collectionView?.dataSource = self
        
        //collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "Cell")
        
        
       fetchReference.observe(.value) {[weak self] snapshot in
           // self?.list = [""]
            self?.list.removeAll()
       
        
        //self?.collectionView?.deleteSections()
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let imgURL = snap.children.allObjects[0] as! DataSnapshot
                print(snap.key)
                // print(imgURL.value!)
                self?.list.append(imgURL.value as! String)
                self?.keys.append(snap.key as! String)
                
            }
            self?.collectionView?.reloadData()
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    /*func retriveImagesFromFirebase()
    {
        fetchReference.observe(.value) {[weak self] snapshot in
            self?.list = [""]
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let imgURL = snap.children.allObjects[0] as! DataSnapshot
                // print(imgURL.value!)
                self?.list.append(imgURL.value as! String)
            }
            self?.collectionView?.reloadData()
    }
    }*/
    
    var imagePicker = UIImagePickerController()
    
    @IBAction func selectImage(_ sender: Any)
    {
        self.list.removeAll()
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    /*func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
    }*/
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //let selectedimage = info[UIImagePickerControllerOriginalImage] as! UIImage!
        let randomIdForImageName = NSUUID().uuidString
       var storeImageRef = Storage.storage().reference().child("Images").child("\(randomIdForImageName).png")
        
        
        
        var selectedImage: UIImage!
        
     
        
        selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage!
        
        if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            selectedImage = originalImage
            print(originalImage.size)
        }
        let uploadImageToFirebase = UIImagePNGRepresentation(selectedImage!)
        //firebaseReference.putData(uploadImageToFirebase!, metadata: nil)
        
        storeImageRef.putData(uploadImageToFirebase!, metadata: nil, completion:
            { (metadata, error) in
                
                if error != nil {
                    print(error)
                    return
                }
                
                if let urlOfImage = metadata?.downloadURL()?.absoluteString {
                    
                    self.rootRef.child("Images").child((Auth.auth().currentUser?.uid)!).child(randomIdForImageName).setValue(["url": urlOfImage])
                    
                }
                
        })
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logOut(_ sender: Any)
    {
        try! Auth.auth().signOut()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let LoginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        self.present(LoginViewController, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        print("count")
        print(list.count)
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return list.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //self.collectionView?.delegate = self
        //self.collectionView?.dataSource = self
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! VideoCell
        //cell.imageFromFirebase!.sd_setImage(with: URL(string: self.list[indexPath.row]), placeholderImage: UIImage(named: "add.png"))
        cell.imageV!.sd_setImage(with: URL(string: self.list[indexPath.row]), placeholderImage: UIImage(named: "add.png"))
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(indexPath.row)
        //self.performSegue(withIdentifier:"eachImage", sender: collectionView.cellForItem(at: indexPath))
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "eachImage" {
            let DetailPhotoViewController = segue.destination as! DetailPhotoViewController
            
            let indexPaths : NSArray = self.collectionView?.indexPathsForSelectedItems! as! NSArray
            let indexPath : NSIndexPath = indexPaths[0] as! NSIndexPath
            print("qwety")
            print(keys[indexPath.row])
            
            DetailPhotoViewController.url = list[indexPath.row]
            DetailPhotoViewController.key = keys[indexPath.row]
            
            
        }
        
    }
}

class VideoCell:UICollectionViewCell
{
        @IBOutlet weak var imageV: UIImageView!
}
