//
//  AddItemTableViewController.swift
//  ToDoList
//
//  Created by Loris Mazloum on 8/28/16.
//  Copyright © 2016 Loris Mazloum. All rights reserved.
//

import UIKit

class AddItemTableViewController: UITableViewController {
    
    //MARK: Outlets
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var itemDescriptionTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func cancelButtonPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    var item: Item!
    var list: List!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Handle the text field’s user input via delegate callbacks.
        //itemNameTextField.delegate = self
        
        
        if let item = item {
            itemNameTextField.text = item.title
            itemDescriptionTextField.text = item.description
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if saveButton === sender as? UIBarButtonItem {
            
            print("let's' save")
            let name = itemNameTextField.text ?? ""
            let description = itemDescriptionTextField.text ?? ""

            item = Item(title: name, description: description)
            
        }
        
    }


}
