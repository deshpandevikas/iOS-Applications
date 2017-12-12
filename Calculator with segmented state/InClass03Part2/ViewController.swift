//
//  ViewController.swift
//  InClass03Part2
//
//  Created by Deshpande, Vikas on 9/21/17.
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

    @IBOutlet weak var firstNumber: UITextField!

    @IBOutlet weak var secondNumber: UITextField!
    
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var f = 0.0
    var s = 0.0
    var res = 0.0
    
    func validateNumbers() -> Bool
    {
        if(firstNumber.text=="" || secondNumber.text=="")
        {
            print("Please Enter the numbers")
            let alert = UIAlertController(title: "dfghgfdfghjk", message: "Enter Valid Input", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        return true
        
    }
    
    @IBAction func clearFunc(_ sender: Any)
    {
        print("Hello World! This is clearAll function")
        self.firstNumber.text = ""
        self.secondNumber.text = ""
        resultLabel.text = "0.00"

    }
    
    
    @IBOutlet weak var whichOperation: UISegmentedControl!
    
    
    
   
    @IBAction func perfromOperation(_ sender: Any)
    {
        if(whichOperation.selectedSegmentIndex==0)
        {
            print("Hello World! This is add function")
            if(validateNumbers())
            {
                
                f = Double(firstNumber.text!)!
                s = Double(secondNumber.text!)!
                res = f + s
                resultLabel.text = "\(res)";
                
            }
        }
        else if(whichOperation.selectedSegmentIndex==1)
        {
            print("Hello World! This is add function")
            if(validateNumbers())
            {
                
                f = Double(firstNumber.text!)!
                s = Double(secondNumber.text!)!
                res = f - s
                resultLabel.text = "\(res)";
                
            }
        }
        else if(whichOperation.selectedSegmentIndex==2)
        {
            print("Hello World! This is add function")
            if(validateNumbers())
            {
                
                f = Double(firstNumber.text!)!
                s = Double(secondNumber.text!)!
                res = f * s
                resultLabel.text = "\(res)";
                
            }
        }
        else if(whichOperation.selectedSegmentIndex==3)
        {
            if(validateNumbers())
            {
                f = Double(firstNumber.text!)!
                s = Double(secondNumber.text!)!
                if(s==0.0)
                {
                    //print("Please Enter the second Number other than zero!")
                    let alert = UIAlertController(title: "Divide by Zero Error", message: "Please enter second number other than zero", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    secondNumber.text = ""
                }
                else
                {
                    res = f/s
                    resultLabel.text = "\(res)";
                }
                
            }
        }
    }
    
    
}

