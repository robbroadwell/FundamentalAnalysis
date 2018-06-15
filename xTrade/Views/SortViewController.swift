//
//  SortViewController.swift
//  xTrade
//
//  Created by Rob Broadwell on 6/15/18.
//  Copyright © 2018 Rob Broadwell. All rights reserved.
//

import UIKit

protocol SortDelegate {
    func sortBySortCriteria(_ sort: SortCriteria)
}

struct SortCriteria {
    var displayName: String
    var sortField: String
    var ascending: Bool
}

class SortViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var sortDelegate: SortDelegate?
    
    @IBOutlet weak var tableView: UITableView!
    
    private var sortCriteria: [SortCriteria] = [SortCriteria(displayName: "Market Cap", sortField: "marketCap", ascending: false),
                                                SortCriteria(displayName: "Profit Margin", sortField: "profitMargin", ascending: false),
                                                SortCriteria(displayName: "Dividend Yield", sortField: "dividendYield", ascending: false),
                                                SortCriteria(displayName: "Price to Book", sortField: "priceToBook", ascending: true),
                                                SortCriteria(displayName: "Price to Earnings", sortField: "priceToEarnings", ascending: true),
                                                SortCriteria(displayName: "Return on Equity", sortField: "returnOnEquity", ascending: false)]
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortCriteria.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let sort = sortCriteria[indexPath.row]
        
        cell.textLabel?.text = sort.displayName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sortDelegate?.sortBySortCriteria(sortCriteria[indexPath.row])
    }
    
}
