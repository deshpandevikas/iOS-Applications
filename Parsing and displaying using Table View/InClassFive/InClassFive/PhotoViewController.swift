//
//  PhotoViewController.swift
//  InClassFive
//
//  Created by Deshpande, Vikas on 10/5/17.
//  Copyright © 2017 Deshpande, Vikas. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    
    
    var index = 0
    var totalCount: Int = 0
    
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBAction func prevImageFunction(_ sender: Any)
    {
        if(index == 0)
        {
            index = totalCount - 1
        }
        else
        {
            index = index - 1
        }
        getImageFromURL()
    }
    
    @IBOutlet weak var prevBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBAction func nextImageFunction(_ sender: Any)
    {
        if(index == totalCount-1)
        {
            index = 0
        }
        else
        {
            index = index + 1
        }
        getImageFromURL()
    }
    
    @IBOutlet weak var textzfield: UILabel!
    
    var name22:String=""
    //var count:Int=0
    
    func getImageFromURL(){
        let createURL : String  = "http://dev.theappsdr.com/lectures/inclass_http/photos.php?category=\(name22)&pid=\(index)"
        print(createURL)
        spinner.startAnimating()
        prevBtn.isEnabled = false
        nextBtn.isEnabled = false
        let URLL = URL(string:createURL)
        
        DispatchQueue.global(qos:.userInitiated).async
            {
                let responseFromURL = try? Data(contentsOf:URLL!)
                
                if let imageResponse = responseFromURL
                {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data:imageResponse)
                        self.spinner.stopAnimating()
                        self.prevBtn.isEnabled = true
                        self.nextBtn.isEnabled = true
                    }
                }
        }
        
        
    }
    
    
    
    func getImageCount(){
        let createURL : String = "http://dev.theappsdr.com/lectures/inclass_http/photos.php?count=get&category=\(name22)"
        print(createURL)
        let URLLL = URL(string:createURL)
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let contents = try? Data(contentsOf: URLLL!)
            if let imageData = contents {
                DispatchQueue.main.async {
                    var total = String(data: contents!, encoding: String.Encoding.utf8)!
                    self?.totalCount = Int(total)!
                }
            }
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(name22)
        print(totalCount)
        //textzfield.text = name22
        getImageFromURL()
        getImageCount()
    }

        // Do any additional setup after loading the view.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    }




