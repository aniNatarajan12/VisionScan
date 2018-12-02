//
//  MemoriesController.swift
//  VisionScan
//
//  Created by Anirudh Natarajan on 12/1/18.
//  Copyright © 2018 Anirudh Natarajan. All rights reserved.
//

import Foundation
import UIKit

class MemoriesController: UITableViewController {
    
    override func viewDidLoad() {
        tableView.contentInset = UIEdgeInsets(top: 25, left: 0, bottom: 5, right: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return keys.count
    }
    // There is just one row in every section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Set the spacing between sections
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    // Make the background color show through
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! TableViewCell
        cell.titleLabel.text = keys[indexPath.section]
        cell.significanceLabel.text = UserDefaults.standard.string(forKey: keys[indexPath.section])
        cell.layer.cornerRadius = 15
        cell.clipsToBounds = true
        return cell
    }
}
