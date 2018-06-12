//
//  DataController.swift
//  xTrade
//
//  Created by Rob Broadwell on 6/12/18.
//  Copyright © 2018 Rob Broadwell. All rights reserved.
//

import Foundation

class DataController {
    
    var symbols: [String] {
        let nyse = NYSE.symbols.lines
        let nasdaq = Nasdaq.symbols.lines
        return nyse + nasdaq
    }
    
    var stocks: Results<Stock>!
    
    func initialize() {
        GlobalNetworkController.register(delegate: self)
        populateRealm()
        fetchData()
    }
    
    func populateRealm() {
        let realm = try! Realm()
        
        for symbol in symbols {
            if !symbol.contains("^") {
                try! realm.write {
                    print("realm object created for \(symbol)")
                    realm.create(Stock.self, value: ["id": symbol, "symbol": symbol], update: true)
                }
            }
        }
        
        stocks = realm.objects(Stock.self)
    }
    
    func fetchData() {
        guard let stocks = self.stocks else { return }
        for stock in stocks {
            if stock.needsRefresh() {
                GlobalNetworkController.fetchData(for: stock, andEndpoint: .earnings)
                GlobalNetworkController.fetchData(for: stock, andEndpoint: .financials)
                GlobalNetworkController.fetchData(for: stock, andEndpoint: .stats)
                
                let realm = try! Realm()
                try! realm.write {
                    stock.fetched = Date()
                }
            }
        }
    }
    
}
