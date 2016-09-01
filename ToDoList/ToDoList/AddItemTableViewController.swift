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

    // MARK: Actions
    @IBAction func cancelButtonPressed(_ sender: AnyObject) {
        //if from modal, dismiss the page
        if(presentingViewController != nil){
            dismiss(animated: true, completion: nil)
        }
        
        //if from push, pop the view
        if let navigationController = navigationController {
            navigationController.popViewController(animated: true);
        }
    
    }
    
    var item: Item!
    var list: List!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = item {
            self.title = "Edit Item"
            itemNameTextField.text = item.title
            itemDescriptionTextField.text = item.description
        }
    
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if saveButton === sender as? UIBarButtonItem {
            
            guard let name = itemNameTextField.text else { return true }
            
            if (name.isEmpty) {
                displayError()
                return false
                
            } else {
                return true
                
            }
            
        }
        
        return true
    }
    
    func displayError(){
        
        let alertController = UIAlertController(title: "Empty Item Name", message:
            "Please enter a to-do before saving", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if saveButton === sender as? UIBarButtonItem {
            
            print("let's' save")
            let name = itemNameTextField.text ?? ""
            let description = itemDescriptionTextField.text ?? ""

            item = Item(title: name, description: description)
            
        }
        
    }


}
