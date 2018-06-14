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
    
    private var ascending = false

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        token = GlobalDataController.sorted.observe { changes in
            if GlobalDataController.filtered.count != 0  {
                self.title = "\(GlobalDataController.filtered.count) securities"
                self.tableView.reloadData()
            }
        }
        
    }
    
    @IBAction func sortPressed(_ sender: Any) {
        let sort = SortCriteria(displayName: "Market Capitalization", sortField: "marketCap", ascending: false)
        GlobalDataController.sortBySortCriteria(sort)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let stock = GlobalDataController.filtered[indexPath.row]
        
        if let marketCap = stock.marketCap.value {
            let string = stock.symbol + "/" + stock.name + "/" + String(marketCap)
            cell.textLabel?.text = string
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GlobalDataController.filtered.count
    }
    
    deinit {
        token.invalidate()
    }
}
