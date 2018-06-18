//
//  DetailViewController.swift
//  xTrade
//
//  Created by Rob Broadwell on 6/12/18.
//  Copyright © 2018 Rob Broadwell. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SortDelegate {
    
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
    
    func    sortBySortCriteria(_ sort: SortCriteria) {
        GlobalDataController.sortBySortCriteria(sort)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        
        switch identifier {
        case "ShowSort":
            if let destination = segue.destination as? SortViewController {
                destination.sortDelegate = self
            }
        default:
            print("Unexpected segue: \(identifier)")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath) as? StockCell else {
            return UITableViewCell()
        }
        
        let stock = GlobalDataController.filtered[indexPath.row]
        let format = ".2" // two decimal places
        
        cell.dividendYieldLabel.text = (stock.dividendYield.value ?? 0.0).format(f: format)
        cell.priceLabel.text = (stock.price.value ?? 0.0).format(f: format)
        cell.priceToEarningsLabel.text = (stock.priceToEarnings.value ?? 0.0).format(f: format)
        cell.profitMarginLabel.text = (stock.profitMargin.value ?? 0.0).format(f: format)
        cell.returnOnEquityLabel.text = (stock.returnOnEquity.value ?? 0.0).format(f: format)
        cell.marketCapitalizationLabel.text = (stock.marketCap.value ?? 0.0).formatWithCommas()
        
        cell.symbolLabel.text = stock.symbol

        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return StockHeader.instanceFromNib()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GlobalDataController.filtered.count
    }
    
    deinit {
        token.invalidate()
    }
}
