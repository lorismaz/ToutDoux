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
    var items: [Item]!
    //var selectedSegment: Int!
    
    var segmentItems: [Item]!
    
    // MARK: Properties
    // segment switch outlet
    @IBOutlet weak var statusSegmentControl: UISegmentedControl!
    
    // segment switch action
    @IBAction func segmentedControlActionChanged(_ sender: AnyObject) {
        getSegmentItems()
        self.tableView.reloadData()
    }
    
    // MARK: Logic
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Setting up segment Items to show
       
        getSegmentItems()
        
        
        let listName = listData.name
        self.title = "\(listName) List"
        
    }
    
    func getSegmentItems() {
        let items = listData.items
        
        var allItems: [Item] = []
        var completedItems: [Item] = []
        var newItems: [Item] = []
            
        for item in items {
            
            if item.isCompleted {
                completedItems.append(item)
            } else {
                newItems.append(item)
            }
            
            allItems.append(item)
            
        }
        
        
        switch(statusSegmentControl.selectedSegmentIndex)
        {
        case 0:
            segmentItems = newItems
        case 2:
            segmentItems = completedItems
        default:
            segmentItems = allItems
        }
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
        
        guard let segment = segmentItems else { return 0 }
        return segment.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as! ItemTableViewCell
        
        //load item
        let item = segmentItems[(indexPath as NSIndexPath).row]
        
        //set item name
        cell.itemNameLabel.text = item.title
        
        //on checkbox click
        cell.onClick = { cell in
            
            guard let indexPath = tableView.indexPath(for: cell) else { return }
            
            let item = self.segmentItems[indexPath.row]
            print("Row \(item.title) " )
            
            //switch status
            item.isCompleted = !item.isCompleted
            tableView.reloadData()
        }
    
        //returning correct icons and colors for each item's status
        if item.isCompleted {
            // Introducing the statusji™
            cell.statusLabel.text = item.statusji
            cell.itemNameLabel.textColor = UIColor.gray
        } else {
            cell.statusLabel.text = ""
            cell.itemNameLabel.textColor = UIColor.black
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        
        //let items = listData.items
        //guard let item = segmentItems[row] else { return }
        let item = segmentItems[row]
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
            guard let itemDetailViewController = segue.destination as? ItemDetailTableViewController else { return
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
            
            // TODO: will crash on deleting complete items, from the item view
            listData.items.remove(at: row)
            getSegmentItems()
            
            tableView.reloadData()
            //let count = segmentItems.count
            //let newIndexPath = NSIndexPath(row: count, section: 0)
            //tableView.deleteRows(at: [newIndexPath as IndexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    
    // get the item from the edit view // function sender parameter is a segue, and is used in IB in the Exit button
    // from the Apple Food Tracker tutorial
    @IBAction func unwindToItemTable(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? ItemDetailTableViewController, let item = sourceViewController.item {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                
                // Update an existing item.
                //listData.items[selectedIndexPath.row] = item
                segmentItems[selectedIndexPath.row] = item
                
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
                
            } else {
                
                // Add a new item.
                
                // Go back to All segment if adding an item from the Done segment
                if statusSegmentControl.selectedSegmentIndex == 2 {
                    statusSegmentControl.selectedSegmentIndex = 1
                }
                
                let count = listData.items.count
                let newIndexPath = NSIndexPath(row: count, section: 0)
                print(newIndexPath.row)
                
                //add item to list
                listData.items.append(item)
                
                getSegmentItems()
                
                //tableView.insertRows(at: [newIndexPath as IndexPath], with: .bottom)
                tableView.reloadData()
                
            }
            
        }
        
        
    }

}
