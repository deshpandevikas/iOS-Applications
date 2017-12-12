//
//  DetailsDisplayPage.swift
//  InClass04
//
//  Created by Deshpande, Vikas on 9/28/17.
//  Copyright © 2017 Deshpande, Vikas. All rights reserved.
//

import UIKit

class DetailsDisplayPage: UIViewController {
    
    
    
    var users1: Users = Users()
    
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Email: UILabel!
    @IBOutlet weak var Password: UILabel!
    @IBOutlet weak var Dept: UILabel!
    
    @IBOutlet weak var showHidePassword: UIButton!
    
    
    @IBAction func showHidePassword(_ sender: UIButton)
    {
        if sender.currentTitle == "Show"
        {
            Password.text = users1.userPassword
            sender.setTitle("Hide", for: UIControlState.normal )
        }
        else{
            var str = ""
            for _ in users1.userPassword.characters{
                str = str+"*"
            }
            
            Password.text = str
            sender.setTitle("Show", for: UIControlState.normal )
            
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Name.text = users1.userName
        Email.text = users1.userEmail
        Password.text = users1.userPassword
        Dept.text = users1.userDepartment
        var str = ""
        for _ in users1.userPassword.characters{
            str = str+"*"
        }
        Password.text = str
        

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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        if let srcc = segue.source as? NameEditViewController{
            Name.text = srcc.EditNameTextField.text
            users1.userName = srcc.EditNameTextField.text!
        }
        if let srcc = segue.source as? EmailEditViewController{
            Email.text = srcc.EditEmailTextField.text
            users1.userEmail = srcc.EditEmailTextField.text!
        }
        if let srcc = segue.source as? DepartmentEditViewController{
            Dept.text = srcc.department
            users1.userDepartment = srcc.department
        }
        if let srcc = segue.source as? PasswordEditViewController{
            users1.userPassword = srcc.EditPasswordTextField.text!
            if(showHidePassword.currentTitle=="Show"){
                var str = ""
                for _ in users1.userPassword.characters{
                    str = str+"*"
                }
                
                Password.text = str
            }
            else
            {
                    Password.text = srcc.EditPasswordTextField.text
            }
            
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        switch segue.identifier! {
        case "EditNameSegue":
            let updateName: NameEditViewController = segue.destination as! NameEditViewController
            updateName.editNameString = users1.userName
        case "EditEmailSegue":
            let updateEmail: EmailEditViewController = segue.destination as! EmailEditViewController
            updateEmail.editEmailValue = users1.userEmail
        case "EditDeptSegue":
            let updateDepartment: DepartmentEditViewController = segue.destination as! DepartmentEditViewController
            updateDepartment.department = users1.userDepartment
        case "EditPwdSegue":
            let updatePassword: PasswordEditViewController = segue.destination as! PasswordEditViewController
            updatePassword.passworddd = users1.userPassword
        default:break
            
        }
        
    }

}
