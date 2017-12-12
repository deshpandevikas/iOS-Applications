//
//  ViewController.swift
//  InClass04
//
//  Created by Deshpande, Vikas on 9/28/17.
//  Copyright © 2017 Deshpande, Vikas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var personName: UITextField!
    @IBOutlet weak var personPassword: UITextField!
    @IBOutlet weak var personEmailId: UITextField!
    
    var dept = "CS";
    
    @IBAction func whichDepartment(_ sender: AnyObject)
    {
        switch sender.selectedSegmentIndex!
        {
            case 0: dept = "CS";
            case 1: dept = "SIS";
            case 3: dept = "BIO";
            default:break;
        }
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
         if(personName.text?.count != 0 && personEmailId.text?.count != 0 && personPassword.text?.count != 0)
         {
            return true
        }
         else{
            let alert = UIAlertController(title: "There are empty fields", message: "Please fill all the details", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok, I will", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let detailsVC: DetailsDisplayPage = segue.destination as! DetailsDisplayPage
        let userObj = Users(userName: personName.text!, userEmail: personEmailId.text!, userPassword: personPassword.text!, userDepartment: dept)
        detailsVC.users1 = userObj
    }
    
    
    
}


