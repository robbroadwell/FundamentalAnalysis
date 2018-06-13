//
//  DetailViewController.swift
//  xTrade
//
//  Created by Rob Broadwell on 6/12/18.
//  Copyright © 2018 Rob Broadwell. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var token: NotificationToken!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "6,421 Securities"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        token = GlobalDataController.stocks.observe { changes in
            self.tableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let stock = GlobalDataController.sorted[indexPath.row]
        let string = stock.symbol + "/" + stock.name + "/" + stock.exchange

        cell.textLabel?.text = string
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GlobalDataController.sorted.count
    }
    
    deinit {
        token.invalidate()
    }
}
