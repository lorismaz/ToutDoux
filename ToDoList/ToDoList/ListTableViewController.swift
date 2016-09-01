//
//  ListTableViewController.swift
//  ToDoList
//
//  Created by Loris Mazloum on 8/28/16.
//  Copyright © 2016 Loris Mazloum. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    var lists: [List] = [
        List(name: "Home", items: nil),
        List(name: "GA", items: [
            Item(title: "Prepare food for the week", description: "Item with a description"),
            Item(title: "Finish the project", description: "Item with a description"),
            Item(title: "Find a job", description: nil),
            Item(title: "Go fishing 🎣", description: nil)
        ]),
        List(name: "Groceries", items: nil)
    ]
    
    //var list: List
    
    // MARK: Properties
    
    // MARK: Actions
    
    // MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return lists.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        
        let list = lists[(indexPath as NSIndexPath).row]
        
        cell.listNameLabel.text = list.name
        cell.backgroundColor = list.color
        cell.listNameLabel.textColor = UIColor.white
        
        return cell
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            lists.remove(at: indexPath.row)
            //self.tableView.reloadData()
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }



    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let row = indexPath.row
        let listData = lists[row]
        
        displayListData(data: listData)
        
    }
    
    
    func displayListData(data: List) {
        performSegue(withIdentifier: "ToListItems", sender: data)
    }
    
//    func displayAddList(data: [List]) {
//        performSegue(withIdentifier: "ToAddList", sender: data)
//    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        if segue.identifier == "ToListItems" {
            print("showing list's items")
            
//            let backItem = UIBarButtonItem()
//            backItem.title = ""
//            navigationItem.backBarButtonItem = backItem
            
            guard let listData = sender as? List else { return }
            guard let itemTableViewController = segue.destination as? ItemTableViewController else { return
            }
            
            itemTableViewController.listData = listData
            
        }
        
        if segue.identifier == "ToAddList" {
            
            print("Adding a list")
            
        }
        
        
    }
    
    @IBAction func unwindToListTable(sender: UIStoryboardSegue) {
        
        if let sourceViewController = sender.source as? AddListTableViewController, let list = sourceViewController.list {
            
            // Add a new list.
            let newIndexPath = NSIndexPath(row: lists.count, section: 0)
            lists.append(list)
            tableView.insertRows(at: [newIndexPath as IndexPath], with: .bottom)
        }
        

    }
 

}


