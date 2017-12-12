    //
    //  NoteBookTableViewController.swift
    //  InClass06App
    //
    //  Created by Deshpande, Vikas on 10/20/17.
    //  Copyright © 2017 Example. All rights reserved.
    //

    import UIKit
    import Firebase

    class NoteBookTableViewController: UITableViewController
    {
        
        let reference = Database.database().reference()
        var noteBookObj = [NoteBook] ()
        var postData = [String]()

        @IBAction func addNewNoteBook(_ sender: Any)
        {
            let noteBooksReference = reference.child("notebooks").child((Auth.auth().currentUser?.uid)!)
            let alert = UIAlertController(title: "New Notebook", message: "Enter Notebook Name", preferredStyle: .alert)
            alert.addTextField(configurationHandler: { (tf) -> Void in
                tf.placeholder = "Notebook name"
            })
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                let textField = alert.textFields![0] as UITextField
                let createdDate = NSDate()
                let dF = DateFormatter()
                dF.dateStyle = DateFormatter.Style.long
                dF.timeStyle = .medium
                let now = dF.string(from: createdDate as Date)
                noteBooksReference.childByAutoId().setValue(["notebookname": textField.text!,"createdDate": now])
                self.tableView.reloadData()
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            }))
            self.present(alert, animated: true, completion: nil)
        }
      
        
        @IBAction func logout(_ sender: Any)
        {
            try! Auth.auth().signOut()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let LoginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
            self.present(LoginViewController, animated: true, completion: nil)
        }
        
        override func viewDidLoad()
        {
            super.viewDidLoad()
            self.tableView.rowHeight = 50
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?)
        {
            if segue.identifier == "segueForNotes"
            {
                if let destination = segue.destination as? NotesTableViewController
                {
                    destination.whichNoteBook = self.noteBookObj[(tableView.indexPathForSelectedRow?.row)!].identifier
                }
            }
            
        }
        
        func fetchNewDataFromFirebase()
        {
            self.noteBookObj = [NoteBook]()
            let noteBooksReference = reference.child("notebooks").child((Auth.auth().currentUser?.uid)!)
            noteBooksReference.observe(.value, with: { (snapshot) -> Void in
                self.noteBookObj = [NoteBook]()
                let enumerator = snapshot.children
                while let eachData = enumerator.nextObject() as? DataSnapshot {
                    let key : String = eachData.key
                    let noteBookName : String = eachData.childSnapshot(forPath: "notebookname").value as! String
                    let noteBookCreatedDate : String = eachData.childSnapshot(forPath: "createdDate").value as! String
                    let noteB = NoteBook(name: noteBookName, identifier: key, date: noteBookCreatedDate)
                    self.noteBookObj.append(noteB)
                }
                self.tableView.reloadData()
            })
        }
        
        override func viewWillAppear(_ animated: Bool)
        {
            tableView.reloadData()
            fetchNewDataFromFirebase()
        }

        override func didReceiveMemoryWarning()
        {
            super.didReceiveMemoryWarning()
        }

        override func numberOfSections(in tableView: UITableView) -> Int
        {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        {
            // #warning Incomplete implementation, return the number of rows
           return noteBookObj.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        {
            /*
             let cell = Bundle.main.loadNibNamed("NoteBookTableViewCell", owner: self , options: nil)?.first as! NoteBookTableViewCell
             
             cell.noteBookName.text = noteBooks[indexPath[1]].Name
             cell.noteBookCreatedDate.text = noteBooks[indexPath[1]].Date
             return cell*/
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = noteBookObj[indexPath[1]].name
            cell.detailTextLabel?.text = noteBookObj[indexPath[1]].date
            return cell
        }
        
        
        
        
      /* override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            [self .performSegue(withIdentifier: "segueMain", sender: self)]
        }*/
        
    }
