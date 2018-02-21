//
//  DataSourceTableViewController.swift
//  MapDemo
//
//  Created by Max Fuller on 2/21/18.
//  Copyright © 2018 Max Fuller. All rights reserved.
//

import UIKit

class DataSourceTableViewController : UITableViewController, UINavigationControllerDelegate, DetailDelegate {
 
    @IBOutlet weak var baseTextField: UITextField!
    @IBOutlet weak var tableTextField: UITextField!
    @IBOutlet weak var viewTextField: UITextField!
    @IBOutlet weak var locationCell: UITableViewCell!
    var currentLocationColSelected = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshAndUpdate()
    }
    
    @IBAction func baseEditingChanged(_ sender: Any) {
        refreshAndUpdate()
    }
    
    @IBAction func tableEditingChanged(_ sender: Any) {
        refreshAndUpdate()
    }
    
    @IBAction func viewEditingChanged(_ sender: Any) {
        refreshAndUpdate()
    }
    
    private func refreshAndUpdate() {
        currentLocationColSelected = 0
        DataManager.instance.base = baseTextField.text ?? ""
        DataManager.instance.table = tableTextField.text ?? ""
        DataManager.instance.view = viewTextField.text ?? ""
        DataManager.instance.refreshData() {
            self.updateLocationField()
        }
        updateLocationField()
    }
    
    private func updateLocationField() {
        if DataManager.instance.fieldNames.count == 0 {
            locationCell.isUserInteractionEnabled = false
            locationCell.textLabel?.text = "No data for this View"
        } else {
            locationCell.isUserInteractionEnabled = true
            locationCell.textLabel?.text = DataManager.instance.fieldNames[currentLocationColSelected]
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? DetailTableViewController {
            controller.selectedIndex = currentLocationColSelected
            controller.delegate = self
        }
    }
    
    func didSelectIndex(index: Int) {
        currentLocationColSelected = index
        updateLocationField()
    }

    
}
