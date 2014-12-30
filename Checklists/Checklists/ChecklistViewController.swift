//
//  ChecklistViewController.swift
//  Checklists
//
//  Created by Brian Ledbetter on 12/30/14.
//  Copyright (c) 2014 Brian Ledbetter. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {
    var items = [ChecklistItem]()
    var checkListItem = ChecklistItem()
    
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
    
    func configureCheckmarkForCell(cell: UITableViewCell, indexPath: NSIndexPath) {
        let item = items[indexPath.row]
        if item.checked {
            cell.accessoryType = .Checkmark
        }else{
            cell.accessoryType = .None
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChecklistItem", forIndexPath: indexPath) as UITableViewCell
        return cell
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
        // 1
        return 100
    }
}