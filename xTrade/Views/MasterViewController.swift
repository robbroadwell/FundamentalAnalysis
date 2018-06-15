//
//  MasterViewController.swift
//  xTrade
//
//  Created by Rob Broadwell on 6/12/18.
//  Copyright © 2018 Rob Broadwell. All rights reserved.
//

import UIKit

struct FilterCriteria {
    var displayName: String
    var predicates: [NSPredicate]
}

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    
    let factors = ["Profit Margin",
                   "Price",
                   "Dividend",
                   "Price/Book",
                   "Return on Equity",
                   "Price/Earnings"]
    
    let marketCaps = [FilterCriteria(displayName: "Small Cap: <$2B",
                                    predicates: [NSPredicate(format: "marketCap < 2000000000")]),
                      FilterCriteria(displayName: "Medium Cap: $2B-$20B",
                                    predicates: [NSPredicate(format: "marketCap > 2000000000"),
                                                 NSPredicate(format: "marketCap < 20000000000")]),
                      FilterCriteria(displayName: "Large Cap: >$20B",
                                    predicates: [NSPredicate(format: "marketCap > 20000000000")])]
    
    let industries = [FilterCriteria(displayName: "Real Estate",
                                    predicates: [NSPredicate(format: "sector == %@", "Real Estate")]),
                      FilterCriteria(displayName: "Technology",
                                    predicates: [NSPredicate(format: "sector == %@", "Technology")]),
                      FilterCriteria(displayName: "Basic Materials",
                                    predicates: [NSPredicate(format: "sector == %@", "Basic Materials")]),
                      FilterCriteria(displayName: "Healthcare",
                                    predicates: [NSPredicate(format: "sector == %@", "Healthcare")]),
                      FilterCriteria(displayName: "Energy",
                                    predicates: [NSPredicate(format: "sector == %@", "Energy")]),
                      FilterCriteria(displayName: "Communication Services",
                                    predicates: [NSPredicate(format: "sector == %@", "Communication Services")]),
                      FilterCriteria(displayName: "Industrials",
                                    predicates: [NSPredicate(format: "sector == %@", "Industrials")]),
                      FilterCriteria(displayName: "Financials",
                                    predicates: [NSPredicate(format: "sector == %@", "Financial Services")]),
                      FilterCriteria(displayName: "Utilities",
                                    predicates: [NSPredicate(format: "sector == %@", "Utilities")]),
                      FilterCriteria(displayName: "Consumer Cyclical",
                                    predicates: [NSPredicate(format: "sector == %@", "Consumer Cyclical")]),
                      FilterCriteria(displayName: "Consumer Defensive",
                                    predicates: [NSPredicate(format: "sector == %@", "Consumer Defensive")])]
    
    let type = [FilterCriteria(displayName: "Stock",
                              predicates: [NSPredicate(format: "issueType == %@", "cs")]),
                FilterCriteria(displayName: "ETF",
                              predicates: [NSPredicate(format: "issueType == %@", "et")])]

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
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0: return "Market Capitalization"
        case 1: return "Industry"
        case 2: return "Type"
        default: return "Error"
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0: return marketCaps.count
        case 1: return industries.count
        case 2: return type.count
        default: return 0
        }
    }
    
    private func criteriaForIndexPath(_ indexPath: IndexPath) -> FilterCriteria? {
        switch indexPath.section {
        case 0: return marketCaps[indexPath.row]
        case 1: return industries[indexPath.row]
        case 2: return type[indexPath.row]
        default: return nil
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        var title = ""
        
        if let query = criteriaForIndexPath(indexPath) {
            title = query.displayName
        }
        
        cell.textLabel?.text = title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        GlobalDataController.filterByFilterCriteria(criteriaForIndexPath(indexPath))
    }

}

