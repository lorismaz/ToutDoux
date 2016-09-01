//
//  AddListTableViewController.swift
//  ToDoList
//
//  Created by Loris Mazloum on 8/28/16.
//  Copyright © 2016 Loris Mazloum. All rights reserved.
//

import UIKit

class AddListTableViewController: UITableViewController {
    
    // MARK: Properties
    @IBOutlet weak var listNameTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func cancelButtonPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    var list: List?
    var lists: [List]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard (lists) != nil else { return }
        
        //listNameTextField.delegate = self
        // Enable the Save button only if the text field has a valid Meal name.
        checkValidListName()
        
        //self.listNameTextField.becomeFirstResponder()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    func checkValidListName() {
        // Disable the Save button if the text field is empty.
        let text = listNameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        checkValidListName()
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if saveButton === sender as? UIBarButtonItem {
        
            print("let's' save")
            let name = listNameTextField.text ?? ""
            list = List(name: name, items: nil)

        }
        
    }

}
