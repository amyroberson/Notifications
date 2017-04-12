//
//  ViewController.swift
//  ShoppingListAlerts
//
//  Created by Amy Roberson on 4/12/17.
//  Copyright © 2017 Amy Roberson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var txtAddItem: UITextField!
    
    @IBOutlet weak var tbleShoppingList: UITableView!
    
    @IBOutlet weak var btnAction: UIButton!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var shoppingList: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tbleShoppingList.delegate = self
        self.tbleShoppingList.dataSource = self
        
        self.txtAddItem.delegate = self
        datePicker.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: IBAction methods
    
    @IBAction func scheduleReminder(_ sender: AnyObject) {
        
    }
    
    //MARK: UITableView methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCellItem")! as UITableViewCell
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    //MARK: TextField delegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let listItem = textField.text {
            
            shoppingList.append(listItem)
            
            tbleShoppingList.reloadData()
            txtAddItem.text = ""
            txtAddItem.resignFirstResponder()
        }
        return true
    }
    
    
}

