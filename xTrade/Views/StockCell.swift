//
//  StockCell.swift
//  xTrade
//
//  Created by Rob Broadwell on 6/15/18.
//  Copyright © 2018 Rob Broadwell. All rights reserved.
//

import UIKit

class StockCell: UITableViewCell {
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dividendYieldLabel: UILabel!
    @IBOutlet weak var returnOnEquityLabel: UILabel!
    @IBOutlet weak var profitMarginLabel: UILabel!
    @IBOutlet weak var priceToEarningsLabel: UILabel!
    @IBOutlet weak var marketCapitalizationLabel: UILabel!
}
