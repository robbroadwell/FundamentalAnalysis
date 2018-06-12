//
//  MasterViewController.swift
//  xTrade
//
//  Created by Rob Broadwell on 6/12/18.
//  Copyright © 2018 Rob Broadwell. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    
    let factors = ["Profit Margin",
                   "Price",
                   "Dividend",
                   "Price/Book",
                   "Return on Equity",
                   "Price/Earnings"]
    
    let marketCaps = ["Small Cap: <$2B",
                      "Medium Cap: $2B-$10B",
                      "Large Cap: >$10B"]
    
    let industries = ["Real Estate",
                      "Technology",
                      "Materials",
                      "Healthcare",
                      "Energy",
                      "Telecom",
                      "Industrials",
                      "Financials",
                      "Utilities",
                      "Consumer Discretionary",
                      "Consumer Staples"]
    
    let type = ["ADR",
                "REIT",
                "CE",
                "SI",
                "LP",
                "CS",
                "ETF",
                "Other"]

    override func viewDidLoad() {
        super.viewDidLoad()

        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        self.title = "xTrade 1.0"
        
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "Factors for Overall Rank"
        }
        
        if section == 1 {
            return "Market Capitalization"
        }
        
        if section == 2 {
            return "Industry"
        }
        
        if section == 3 {
            return "Type"
        }
        
        return "Error"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return factors.count
        }
        
        if section == 1 {
            return marketCaps.count
        }
        
        if section == 2 {
            return industries.count
        }
        
        if section == 3 {
            return type.count
        }
        
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        var title = ""
        
        if indexPath.section == 0 {
            title = factors[indexPath.row]
        }
        
        if indexPath.section == 1 {
            title = marketCaps[indexPath.row]
        }
        
        if indexPath.section == 2 {
            title = industries[indexPath.row]
        }
        
        if indexPath.section == 3 {
            title = type[indexPath.row]
        }
        
        cell.textLabel?.text = title
        
        return cell
    }

}

