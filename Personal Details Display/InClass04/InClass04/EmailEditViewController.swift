//
//  EmailEditViewController.swift
//  InClass04
//
//  Created by Deshpande, Vikas on 9/28/17.
//  Copyright © 2017 Deshpande, Vikas. All rights reserved.
//

import UIKit

class EmailEditViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
         EditEmailTextField.text = editEmailValue

        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var EditEmailTextField: UITextField!
    
    var editEmailValue: String = ""
    
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

}
