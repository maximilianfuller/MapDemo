//
//  DataSourceTableViewController.swift
//  MapDemo
//
//  Created by Max Fuller on 2/21/18.
//  Copyright © 2018 Max Fuller. All rights reserved.
//

import UIKit

class DataSourceTableViewController : UITableViewController {
 
    @IBOutlet weak var baseTextField: UITextField!
    
    @IBOutlet weak var tableTextField: UITextField!
    
    @IBOutlet weak var viewTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        refreshDataModel()
    }
    
    @IBAction func baseEditingChanged(_ sender: Any) {
        refreshDataModel()
    }
    
    @IBAction func tableEditingChanged(_ sender: Any) {
        refreshDataModel()
    }
    
    @IBAction func viewEditingChanged(_ sender: Any) {
        refreshDataModel()
    }
    
    private func refreshDataModel() {
        DataManager.instance.base = baseTextField.text ?? ""
        DataManager.instance.table = tableTextField.text ?? ""
        DataManager.instance.view = viewTextField.text ?? ""
        DataManager.instance.refreshData()
    }
    
}
