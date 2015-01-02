//
//  ChecklistViewController.swift
//  Checklists
//
//  Created by Brian Ledbetter on 12/30/14.
//  Copyright (c) 2014 Brian Ledbetter. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate: class {
    func addItemViewControllerDidCancel(controller: AddItemViewController)
    func addItemViewController(controller: AddItemViewController, didFinishAddingItem item: ChecklistItem)
}

class ChecklistViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate, AddItemViewControllerDelegate {
    var items = [ChecklistItem]()
    var checkListItem = ChecklistItem()
    /*
    Initializing
    */
    required init(coder aDecoder: NSCoder) {
        var row0item = ChecklistItem()
        row0item.text = "Walk the dog"
        row0item.checked = false
        items.append(row0item)
        var row1item = ChecklistItem()
        row1item.text = "Brush my teeth"
        row1item.checked = true
        items.append(row1item)
        var row2item = ChecklistItem()
        row2item.text = "Learn iOS development"
        row2item.checked = true
        items.append(row2item)
        var row3item = ChecklistItem()
        row3item.text = "Soccer practice"
        row3item.checked = false
        items.append(row3item)
        var row4item = ChecklistItem()
        row4item.text = "Eat ice cream"
        row4item.checked = true
        items.append(row4item)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    /*
    Custom methods
    */

    func configureCheckmarkForCell(cell: UITableViewCell, indexPath: NSIndexPath) {
        let label = cell.viewWithTag(1001) as UILabel
        let item = items[indexPath.row]
        if item.checked {
            label.text = "√"
        } else {
            label.text = ""
        }
    }
    func configureTextForCell(cell: UITableViewCell, withChecklistItem item: ChecklistItem) {
        let label = cell.viewWithTag(1000) as UILabel
        label.text = item.text
    }
    
    /*
    AddItemViewControllerDelegate Methods
    */
    func addItemViewController(controller: AddItemViewController, didFinishAddingItem item: ChecklistItem) {
        self.items.append(item)
        dismissViewControllerAnimated(true, completion: nil)
    }
    func addItemViewControllerDidCancel(controller: AddItemViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /*
    TableViewing Methods
    */
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChecklistItem", forIndexPath: indexPath) as UITableViewCell
        let item = items[indexPath.row]
        configureTextForCell(cell, withChecklistItem: item)
        configureCheckmarkForCell(cell, indexPath: indexPath)
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        items.removeAtIndex(indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath){
            let item = items[indexPath.row]
            item.checked = !item.checked
            configureCheckmarkForCell(cell, indexPath: indexPath)
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    /*
    Preparing for segues
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "SHOW_DETAIL" {
            let navigationController = segue.destinationViewController as UINavigationController
            let controller = navigationController.topViewController as AddItemViewController
            controller.delegate = self
        } else if segue.identifier == "EDIT_ITEM" {
                let navigationController = segue.destinationViewController as UINavigationController
                let controller = navigationController.topViewController as AddItemViewController
                controller.delegate = self
                
                if let indexPath = tableView.indexPathForCell(sender as UITableViewCell) {
                    controller.itemToEdit = items[indexPath.row]
                }
        }
    }
}

















