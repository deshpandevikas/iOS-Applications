//
//  LoginViewController.swift
//  InClass06App
//
//  Created by Deshpande, Vikas on 10/20/17.
//  Copyright © 2017 Example. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        Auth.auth().addStateDidChangeListener() { auth, user in
            if user != nil {
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let NoteBookTableViewController = storyboard.instantiateViewController(withIdentifier: "NoteBookTableViewController") as! UINavigationController
                self.present(NoteBookTableViewController, animated: true, completion: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBOutlet weak var emailForLogin: UITextField!
    @IBOutlet weak var pwdForLogin: UITextField!
    
    @IBAction func goToRegister(_ sender: Any)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let RegisterViewController = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") 
        self.present(RegisterViewController, animated: true, completion: nil)
    }
    
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
                    let NoteBookTableViewController = storyboard.instantiateViewController(withIdentifier: "NoteBookTableViewController") as! UINavigationController
                    self.present(NoteBookTableViewController, animated: true, completion: nil)
                }
                else {
                    let alert = UIAlertController(title: "Error!", message: "Cant Login due to error", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
    }
}
