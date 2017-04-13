//
//  ShoppingList.swift
//  ShoppingListAlerts
//
//  Created by Amy Roberson on 4/13/17.
//  Copyright © 2017 Amy Roberson. All rights reserved.
//

import UIKit

class ShoppingList: NSObject, UITableViewDataSource {
    private let fileURL: URL = {
       let documentDirectoryURLS = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectoryURL = documentDirectoryURLS.first!
        return documentDirectoryURL.appendingPathComponent("ShoppingList.items")
    }()
    
    fileprivate var items: [String] = []
    
    override init () {
        super.init()
        loadItems()
    }
    
    //this would probably be better with a guard throwing an exception
    func saveItems() {
        let itemsArray = items as NSArray
        if !itemsArray.write(to: fileURL, atomically: true) {
            print("Did not save")
        }
    }
    
    //this would probably be better with a guard throwing an exception
    func loadItems() {
        if let itemsArray = NSArray(contentsOf: fileURL) as? [String] {
            items = itemsArray
        }
    }
    
    func removeItemAtIndex(index: Int) {
        if items.count > index {
            items.remove(at: index)
            saveItems()
        }
        
    }
    
    func add(_ item: String) {
        items.append(item)
        saveItems()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel!.text = item
        return cell
    }

}
