//
//  LoginViewController.swift
//  InClass07
//
//  Created by Deshpande, Vikas on 10/26/17.
//  Copyright © 2017 Sai Nishanth Dilly. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let photosCollection = storyboard.instantiateViewController(withIdentifier: "photosCollection") as! UINavigationController
                self.present(photosCollection, animated: true, completion: nil)
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var pwdForLogin: UITextField!
    @IBOutlet weak var emailForLogin: UITextField!
    
    @IBAction func loginAction(_ sender: Any)
    {
        if self.emailForLogin.text == ""
            || self.pwdForLogin.text == "" {
            let alert = UIAlertController(title: "Error!", message: "Enter all the details", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            Auth.auth().signIn(withEmail: self.emailForLogin.text!, password: self.pwdForLogin.text!, completion: { (user, error) in
                if error == nil {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let photosCollection = storyboard.instantiateViewController(withIdentifier: "photosCollection") as! UINavigationController
                    self.present(photosCollection, animated: true, completion: nil)
                }
                else {
                    let alert = UIAlertController(title: "Error!", message: "Cant Login due to error", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
    }
    /*
     @IBOutlet weak var emailForLogin: UITextField!
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
