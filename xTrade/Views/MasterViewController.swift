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
    var selected: Bool
}

struct SortCriteria {
    var displayName: String
    var sortField: String
    var ascending: Bool
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
                                     predicates: [NSPredicate(format: "marketCap < 2000000000")], selected: true),
                      FilterCriteria(displayName: "Medium Cap: $2B-$20B",
                                    predicates: [NSPredicate(format: "marketCap > 2000000000"),
                                                 NSPredicate(format: "marketCap < 20000000000")], selected: true),
                      FilterCriteria(displayName: "Large Cap: >$20B",
                                     predicates: [NSPredicate(format: "marketCap > 20000000000")], selected: true)]
    
    let industries = [FilterCriteria(displayName: "Real Estate",
                                     predicates: [NSPredicate(format: "sector == %@", "Real Estate")], selected: true),
                      FilterCriteria(displayName: "Technology",
                                     predicates: [NSPredicate(format: "sector == %@", "Technology")], selected: true),
                      FilterCriteria(displayName: "Basic Materials",
                                     predicates: [NSPredicate(format: "sector == %@", "Basic Materials")], selected: true),
                      FilterCriteria(displayName: "Healthcare",
                                     predicates: [NSPredicate(format: "sector == %@", "Healthcare")], selected: true),
                      FilterCriteria(displayName: "Energy",
                                     predicates: [NSPredicate(format: "sector == %@", "Energy")], selected: true),
                      FilterCriteria(displayName: "Communication Services",
                                     predicates: [NSPredicate(format: "sector == %@", "Communication Services")], selected: true),
                      FilterCriteria(displayName: "Industrials",
                                     predicates: [NSPredicate(format: "sector == %@", "Industrials")], selected: true),
                      FilterCriteria(displayName: "Financials",
                                     predicates: [NSPredicate(format: "sector == %@", "Financial Services")], selected: true),
                      FilterCriteria(displayName: "Utilities",
                                     predicates: [NSPredicate(format: "sector == %@", "Utilities")], selected: true),
                      FilterCriteria(displayName: "Consumer Cyclical",
                                     predicates: [NSPredicate(format: "sector == %@", "Consumer Cyclical")], selected: true),
                      FilterCriteria(displayName: "Consumer Defensive",
                                     predicates: [NSPredicate(format: "sector == %@", "Consumer Defensive")], selected: true)]
    
    let type = [FilterCriteria(displayName: "Stock",
                               predicates: [NSPredicate(format: "issueType == %@", "cs")], selected: true),
                FilterCriteria(displayName: "ETF",
                               predicates: [NSPredicate(format: "issueType == %@", "et")], selected: true)]

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
    
    private func allSelectedSearchCriteria() -> [FilterCriteria] {
        var criteria = [FilterCriteria]()
        
        for item in marketCaps {
            if item.selected {
                criteria.append(item)
            }
        }
        
        for item in industries {
            if item.selected {
                criteria.append(item)
            }
        }
        
        for item in type {
            if item.selected {
                criteria.append(item)
            }
        }
        
        if criteria.count == (marketCaps.count + industries.count + type.count) {
            return [FilterCriteria]()
        }
        
        return criteria
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        var title = ""
        
        if let query = criteriaForIndexPath(indexPath) {
            title = query.displayName
            cell.detailTextLabel?.text = query.selected ? "+" : ""
        }
        
        cell.textLabel?.text = title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        GlobalDataController.filterByFilterCriteria(criteriaForIndexPath(indexPath))
        GlobalDataController.filterByFilterCriteria(allSelectedSearchCriteria())
    }

}

