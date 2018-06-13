//
//  Stock.swift
//  xTrade
//
//  Created by Rob Broadwell on 6/12/18.
//  Copyright © 2018 Rob Broadwell. All rights reserved.
//

import Foundation
import RealmSwift

class Stock: Object {
    override static func primaryKey() -> String? {
        return "id"
    }
    
    // meta (for realm)
    @objc dynamic var id: String? = nil
    @objc dynamic var fetched: Date? = nil
    
    // company information
    @objc dynamic var name: String = ""
    @objc dynamic var symbol: String = ""
    @objc dynamic var exchange: String = ""
    @objc dynamic var industry: String = ""
    @objc dynamic var sector: String = ""
    @objc dynamic var ceo: String = ""
    @objc dynamic var issueType: String = ""
    
    // financial information
    let price = RealmOptional<Double>()
    let profitMargin = RealmOptional<Double>()
    let dividendYield = RealmOptional<Double>()
    let priceToBook = RealmOptional<Double>()
    let returnOnEquity = RealmOptional<Double>()
    let priceToEarnings = RealmOptional<Double>()
    let week52high = RealmOptional<Double>()
    let week52low = RealmOptional<Double>()
    let marketCap = RealmOptional<Double>()
    let rank = RealmOptional<Int>()
    
    func needsRefresh() -> Bool {
        if let fetched = self.fetched {
            if let diff = Calendar.current.dateComponents([.hour], from: fetched, to: Date()).hour,
                diff < 24 {
                return false
            }
        }
        return true
    }
}
