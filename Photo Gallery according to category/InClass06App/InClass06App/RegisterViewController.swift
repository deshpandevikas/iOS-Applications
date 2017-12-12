//
//  RegisterViewController.swift
//  InClass06App
//
//  Created by Deshpande, Vikas on 10/20/17.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("In sing up")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     @IBAction func regsiterButton(_ sender: Any) {
     }
     // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBOutlet weak var userConfirmPwd: UITextField!
    @IBOutlet weak var userPwd: UITextField!
    @IBOutlet weak var userEmailId: UITextField!
    @IBOutlet weak var userName: UITextField!
    let reference = Database.database().reference()
    
    
    @IBAction func goBackToLogin(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func regsiterButton(_ sender: Any)
    {
        if self.userName.text == "" || self.userEmailId.text == "" || self.userPwd.text == "" || self.userConfirmPwd.text == ""
        {
            
            let alert = UIAlertController(title: "Missing Fields", message: "Please Fill All the Fields", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        else if self.userPwd.text != self.userConfirmPwd.text
        {
            
            let alert = UIAlertController(title: "Password Mismatch", message: "Password and Confirm Password should be same", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        else
        {
            
            Auth.auth().createUser(withEmail: self.userEmailId.text!, password: self.userPwd.text!, completion: { (user, error) in
                if error == nil
                {
                    let userRef = self.reference.child("users")
                    
                    userRef.child((user?.uid)!).setValue(["Name": self.userName.text!,"email": self.userEmailId.text!])
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let NoteBookTableViewController = storyboard.instantiateViewController(withIdentifier: "NoteBookTableViewController") as! UINavigationController
                    self.present(NoteBookTableViewController, animated: true, completion: nil)
                    
                }
                else
                {
                    let alert = UIAlertController(title: "User Creation Failed", message: error?.localizedDescription , preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
    }
    
}
