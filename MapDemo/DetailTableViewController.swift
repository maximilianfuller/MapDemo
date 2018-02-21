//
//  TextDetailTableView.swift
//  MapDemo
//
//  Created by Max Fuller on 2/21/18.
//  Copyright © 2018 Max Fuller. All rights reserved.
//

import UIKit

protocol DetailDelegate {
    func didSelectIndex(index: Int)
}

class DetailTableViewController : UITableViewController {
    
    var selectedIndex = 0
    var delegate : DetailDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.instance.fieldNames.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell")!
        cell.textLabel!.text = DataManager.instance.fieldNames[indexPath.item]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectIndex(index: indexPath.item)
        navigationController?.popViewController(animated: true)
    }
}
