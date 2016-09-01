//
//  ItemTableViewController.swift
//  ToDoList
//
//  Created by Loris Mazloum on 8/28/16.
//  Copyright © 2016 Loris Mazloum. All rights reserved.
//

import UIKit

class ItemTableViewController: UITableViewController {
    
    var listData: List!
    
    // MARK: Properties
    // segment switch outlet
    @IBOutlet weak var statusSegmentControl: UISegmentedControl!
    
    // segment switch action
    @IBAction func segmentedControlActionChanged(_ sender: AnyObject) {
        self.tableView.reloadData()
    }
    
    // MARK: Logic
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listName = listData.name
        self.title = "\(listName) List"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    // Number of Sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Number of cells
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch(statusSegmentControl.selectedSegmentIndex)
        {
        case 0:
            guard let newItems = listData.getItemsFilteredBy(status: .new) else { return 0 }
            return newItems.count
        case 2:
            guard let completeItems = listData.getItemsFilteredBy(status: .complete) else { return 0 }
            return completeItems.count
        default:
            guard let allItems = listData.items else { return 0 }
            return allItems.count
        }
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as! ItemTableViewCell
        
        var selectedItems: [Item]
        
        // check which segment is selected
        switch(statusSegmentControl.selectedSegmentIndex)
        {
        case 0:
            guard let newItems = listData.getItemsFilteredBy(status: .new) else { return UITableViewCell() }
            selectedItems = newItems
        case 2:
            guard let completeItems = listData.getItemsFilteredBy(status: .complete) else { return UITableViewCell() }
            selectedItems = completeItems
        default:
            guard let allItems = listData.items else { return UITableViewCell() }
            selectedItems = allItems
        }
        
        //load item
        let item = selectedItems[(indexPath as NSIndexPath).row]
        
        cell.itemNameLabel.text = item.title
        
        // Need to learn more about this command
        cell.checkBoxButton.tag = indexPath.row
        
        //cell.buttonTapped(cell.checkBoxButton)
        
        //cell.checkBoxButton.addTarget(self, action: #selector( switchStatus(sender:) ), for: .touchUpInside)
        
        if item.status == .complete {
            cell.itemCheckboxImage.image = UIImage(named: "checked")
            cell.itemNameLabel.textColor = UIColor.gray
        } else {
            cell.itemCheckboxImage.image = UIImage(named: "not-checked")
            cell.itemNameLabel.textColor = UIColor.black
        }
        
        return cell
    }
    
    func switchStatus(sender:UIButton) {
        
        //let indexPath = sender.tag
        //let cell = tableView.cellForRow(at: indexPath)
        
        print("Update Status for \(sender.tag)")
//        var item = item
//        if item.status == .complete {
//            item.setStatus(to: .new)
//        } else {
//            item.setStatus(to: .complete)
//        }
        
        self.tableView.reloadData()
    
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        
        guard let items = listData.items else { return }
        let item = items[row]
        print(item)
        displayItemDetails(item: item)
    }

    func displayItemDetails(item: Item) {
        performSegue(withIdentifier: "ToItemDetails", sender: item)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //add if to compare segue.identifier!!!!!
        if segue.identifier == "ToItemDetails" {
            
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
            
            guard let item = sender as? Item else { return }
            guard let itemDetailViewController = segue.destination as? AddItemTableViewController else { return
            }
            
            itemDetailViewController.item = item
        }
        
        if segue.identifier == "AddItem" {
            
            let backItem = UIBarButtonItem()
            backItem.title = "Cancel"
            navigationItem.backBarButtonItem = backItem
            
            print("Adding new item.")
        }
        
        
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let row = indexPath.row
            //will crash on deleting complete items
            listData.items?.remove(at: row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
 
    @IBAction func unwindToItemTable(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? AddItemTableViewController, let item = sourceViewController.item {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                
                // Update an existing meal.
                listData.items?[selectedIndexPath.row] = item
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
                
            } else {
                
                // Add a new item.
                let newIndexPath = NSIndexPath(row: listData.items!.count, section: 0)
                listData.items!.append(item)
                tableView.insertRows(at: [newIndexPath as IndexPath], with: .bottom)
                
            }
        }
        
        
    }

}
