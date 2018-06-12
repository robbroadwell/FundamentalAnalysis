//
//  NetworkRequestBuilder.swift
//  xTrade
//
//  Created by Rob Broadwell on 6/12/18.
//  Copyright © 2018 Rob Broadwell. All rights reserved.
//


import Foundation

struct NetworkRequestBuilder {
    func request(for stock: Stock, andEndpoint endpoint: NetworkDataEndpoint) -> URLRequest? {
        guard let url = endpoint.url(forSymbol: stock.symbol) else { return nil }
        return URLRequest(url: url)
    }
}

enum NetworkDataEndpoint: String {
    
    case stats = "/stats"
    case company = "/company"
    case quote = "/quote"
    
    func url(forSymbol symbol: String) -> URL? {
        let base = "https://api.iextrading.com/1.0/stock/"
        return URL(string: base + symbol + self.rawValue)
    }
}
