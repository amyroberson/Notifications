//
//  ViewController.swift
//  ShoppingListAlerts
//
//  Created by Amy Roberson on 4/12/17.
//  Copyright © 2017 Amy Roberson. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var txtAddItem: UITextField!
    
    @IBOutlet weak var tbleShoppingList: UITableView!
    
    @IBOutlet weak var btnAction: UIButton!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var shoppingList = ShoppingList()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tbleShoppingList.delegate = self
        self.tbleShoppingList.dataSource = shoppingList
        
        self.txtAddItem.delegate = self
        datePicker.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func animateMyViews(viewToHide: UIView, viewToShow: UIView) {
        let animationDuration = 0.35
        
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            viewToHide.transform = viewToHide.transform.scaledBy(x: 0.001, y: 0.001)
        }) { (completion) -> Void in
            viewToHide.isHidden = true
            viewToShow.isHidden = false
            
            viewToShow.transform = viewToShow.transform.scaledBy(x: 0.001, y: 0.001)
            UIView.animate(withDuration: animationDuration, animations: { () -> Void in
                viewToShow.transform = .identity
            })
        }
    }
    
    func setupNotificationSettings(){
        var notificationTypes: UNNotificationSettings 
    }
    
    //MARK: IBAction methods
    
    @IBAction func scheduleReminder(_ sender: AnyObject) {
        if datePicker.isHidden {
            animateMyViews(viewToHide: tbleShoppingList, viewToShow: datePicker)
        } else {
            animateMyViews(viewToHide: datePicker, viewToShow: tbleShoppingList)
        }
        txtAddItem.isUserInteractionEnabled = !txtAddItem.isUserInteractionEnabled
    }
    
    //MARK: UITableView methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            shoppingList.removeItemAtIndex(index: indexPath.row)
            tbleShoppingList.reloadData()
        }
    }
    
    //MARK: TextField delegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let listItem = textField.text else {
            return true
        }
        
        shoppingList.add(listItem)
        tbleShoppingList.reloadData()
        txtAddItem.text = ""
        txtAddItem.resignFirstResponder()
        
        return true
    }
    
    
}

