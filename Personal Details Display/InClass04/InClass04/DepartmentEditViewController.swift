//
//  DepartmentEditViewController.swift
//  InClass04
//
//  Created by Deshpande, Vikas on 9/28/17.
//  Copyright © 2017 Deshpande, Vikas. All rights reserved.
//

import UIKit

class DepartmentEditViewController: UIViewController {
    @IBOutlet weak var department1: UISegmentedControl!
    var department: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if department == "CS"{
            department1.selectedSegmentIndex = 0
        }
        
        if department == "SIS"{
            department1.selectedSegmentIndex = 1
        }
        
        if department == "BIO"{
            department1.selectedSegmentIndex = 2
        }

        // Do any additional setup after loading the view.
    }

    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateDepartment(sender: AnyObject) {
        switch sender.selectedSegmentIndex{
        case 0: department = "CS"
        case 1: department = "SIS"
        case 2: department = "BIO"
        default: break
        }
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
