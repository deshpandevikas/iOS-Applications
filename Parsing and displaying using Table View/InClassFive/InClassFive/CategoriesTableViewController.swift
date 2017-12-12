//
//  CategoriesTableViewController.swift
//  InClassFive
//
//  Created by Deshpande, Vikas on 10/5/17.
//  Copyright © 2017 Deshpande, Vikas. All rights reserved.
//

import UIKit

class CategoriesTableViewController: UITableViewController {
    
    var rowData = ["Animals", "News", "Entertainment", "Food and Drink", "Cars"]
    
    var ipp: Int = -1;

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rowData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let celldata = rowData[indexPath.row]
        
        cell.textLabel?.text = celldata
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let x = sender as? UITableViewCell
        let indexP = self.tableView.indexPath(for: x!)!
        
        ipp = indexP[1]
        
        switch ipp {
        case 0:
            let updateName: PhotoViewController = segue.destination as! PhotoViewController
            updateName.name22 = "animals"
        case 2:
            let updateEmail: PhotoViewController = segue.destination as! PhotoViewController
            updateEmail.name22 = "entertainment"
            //updateEmail.totalCount = count
        case 4:
            let updateDepartment: PhotoViewController = segue.destination as! PhotoViewController
            updateDepartment.name22 = "car"
        case 3:
            let updatePassword: PhotoViewController = segue.destination as! PhotoViewController
            updatePassword.name22 = "food"
        case 1:
            let updatePassword: PhotoViewController = segue.destination as! PhotoViewController
            updatePassword.name22 = "news"
        default:break
            
        }
        
    }



}
