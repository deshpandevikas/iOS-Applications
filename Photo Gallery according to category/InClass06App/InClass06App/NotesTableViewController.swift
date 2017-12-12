        //
        //  NotesTableViewController.swift
        //  InClass06App
        //
        //  Created by Deshpande, Vikas on 10/21/17.
        //  Copyright © 2017 Example. All rights reserved.
        //

        import UIKit
        import Firebase

        class NotesTableViewController: UITableViewController
        {
            var whichNoteBook : String = ""
            let reference = Database.database().reference()
            var notesInsideNoteBook = [NoteBook] ()
            override func viewDidLoad()
            {
                super.viewDidLoad()
                self.navigationItem.hidesBackButton = true
                let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(NotesTableViewController.back(sender:)))
                self.navigationItem.leftBarButtonItem = newBackButton
            }
            
            override func viewWillAppear(_ animated: Bool)
            {
                tableView.reloadData()
                getDataFromFirebase()
            }
            
            @objc func back(sender: UIBarButtonItem)
            {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let NoteBookTableViewController = storyboard.instantiateViewController(withIdentifier: "NoteBookTableViewController") as! UINavigationController
                self.present(NoteBookTableViewController, animated: false, completion: nil)
            }
            
            override func didReceiveMemoryWarning() {
                super.didReceiveMemoryWarning()
                // Dispose of any resources that can be recreated.
            }
            
            // MARK: - Table view data source
            
            override func numberOfSections(in tableView: UITableView) -> Int {
                // #warning Incomplete implementation, return the number of sections
                return 1
            }
            
            override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                // #warning Incomplete implementation, return the number of rows
                return notesInsideNoteBook.count
            }
            
            override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
            {
                let cell = Bundle.main.loadNibNamed("NotesTableViewCell", owner: self , options: nil)?.first as! NotesTableViewCell
                cell.noteText.text = notesInsideNoteBook[indexPath[1]].name
                cell.noteCreatedDate.text = notesInsideNoteBook[indexPath[1]].date
                cell.noteDelete.addTarget(self, action: #selector(NotesTableViewController.deleteNote(sender:)), for: .touchUpInside)
                cell.noteDelete.tag = indexPath.row
                return cell
            }

            
            override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                
                return UITableViewAutomaticDimension;
            }
            
            
            @objc func deleteNote(sender: UIButton)
            {
                let notesReference = reference.child("notebooks").child((Auth.auth().currentUser?.uid)!).child(whichNoteBook).child("Notes")
                notesReference.child(notesInsideNoteBook[sender.tag].identifier).removeValue()
                getDataFromFirebase()
            }
            
            @IBAction func addNewNote(_ sender: Any)
            {
                let notesReference = reference.child("notebooks").child((Auth.auth().currentUser?.uid)!).child(whichNoteBook).child("Notes")
                let alert = UIAlertController(title: "New Note", message: "Enter New Post Text", preferredStyle: .alert)
                alert.addTextField(configurationHandler:
                { (textField) -> Void in
                    textField.placeholder = "Note text"
                })
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                    let textField = alert.textFields![0] as UITextField
                    let createdDate = NSDate()
                    let dF = DateFormatter()
                    dF.dateStyle = DateFormatter.Style.long
                    dF.timeStyle = .medium
                    let now = dF.string(from: createdDate as Date)
                    notesReference.childByAutoId().setValue(["note": textField.text!,"createdDate": now])
                    self.tableView.reloadData()
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
                }))
                self.present(alert, animated: true, completion: nil)
            }
            
            func getDataFromFirebase()
            {
                self.notesInsideNoteBook = [NoteBook]()
                let notesReference = reference.child("notebooks").child((Auth.auth().currentUser?.uid)!).child(whichNoteBook).child("Notes")
                notesReference.observe(.value, with: { (snapshot) -> Void in
                    self.notesInsideNoteBook = [NoteBook]()
                    let enumerator = snapshot.children
                    while let notesInFirebase = enumerator.nextObject() as? DataSnapshot
                    {
                        let key : String = notesInFirebase.key
                        let noteName : String = notesInFirebase.childSnapshot(forPath: "note").value as! String
                        let noteCreatedDate : String = notesInFirebase.childSnapshot(forPath: "createdDate").value as! String
                        let temp = NoteBook(name: noteName, identifier: key, date: noteCreatedDate)
                        self.notesInsideNoteBook.append(temp)
                    }
                    self.tableView.reloadData()
                })
            }
        }
