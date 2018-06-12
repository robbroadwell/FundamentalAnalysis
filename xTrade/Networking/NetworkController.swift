//
//  NetworkController.swift
//  xTrade
//
//  Created by Rob Broadwell on 6/12/18.
//  Copyright © 2018 Rob Broadwell. All rights reserved.
//

import Foundation

class NetworkController {
    
    /// Constructs URLRequests for available APIs
    var requestBuilder = NetworkRequestBuilder()
    
    /// Singleton object for network requests
    var urlSession = URLSession.shared
    
    /// Delegates to be notified of request completions
    private var delegates = [NetworkDelegate]()
    
    /// Tasks currently scheduled to be executed or already in progress
    private var tasks = [String : URLSessionDataTask]()
    
    /// Requests data for a given endpoint
    func fetchData(for stock: Stock, andEndpoint endpoint: NetworkDataEndpoint) {
        
        if let request = requestBuilder.request(for: stock, andEndpoint: endpoint) {
            let symbol = stock.symbol
            
            print("created requet for \(stock.symbol)")
            let task = urlSession.dataTask(with: request) { (data, response, error) in
                self.networkRequestDidComplete(for: symbol, andEndpoint: endpoint, with: data, response: response, and: error)
            }
            
            let key = stock.symbol + endpoint.rawValue
            
            tasks[key] = task
            task.resume()
        }
        
    }
    
    private func networkRequestDidComplete(for symbol: String, andEndpoint endpoint: NetworkDataEndpoint,
                                           with data: Data?, response: URLResponse?, and error: Error?) {
        // Remove task once it has been completed
        let key = symbol + endpoint.rawValue
        self.tasks.removeValue(forKey: key)
        
        if let error = error {
            notifyDelegatesOnError(endpoint, error: error)
            return
        }
        
        if let data = data {
            print("downloaded data for \(symbol)")
            notifyDelegatesOnSuccess(endpoint, data: data)
            return
        }
    }
}

extension NetworkController {
    
    /// Notifies all observing delegates that a task has completed successfully.
    ///
    /// - Parameters:
    ///   - json: Serialized data from the network operation
    ///   - endpoint: The endpoint that completed
    private func notifyDelegatesOnSuccess(_ endpoint: NetworkDataEndpoint, data: Data) {
        _ = self.delegates.map({ $0.networkManager(didFinishTaskFor: endpoint, with: data) })
    }
    
    /// Notifies all observing delegates that a task has completed with an error.
    ///
    /// - Parameters:
    ///   - error: The error that occured.
    ///   - endpoint: The endpoint that executed.
    private func notifyDelegatesOnError(_ endpoint: NetworkDataEndpoint, error: Error) {
        _ = delegates.map({ $0.networkManager(didFinishTaskFor: endpoint, with: error) })
    }
    
    /// Registers an observer of a given endpoint
    ///
    /// - Parameters:
    ///   - delegate: The delegate to receive a callback.
    ///   - endpoint: The endpoint the delegate would like to observe.
    func register(delegate: NetworkDelegate) {
        if (!self.delegates.contains(where: { $0.equals(with: delegate)})) {
            self.delegates.append(delegate)
        }
    }
    
    /// Unregisters a delegate observer from a given endpoint
    ///
    /// Parameters:
    ///   - delegate: The delegate to unregister
    ///   - endpoint: The endpoint to unregister from
    func unregister(delegate: NetworkDelegate) {
        if let index = self.delegates.index(where: { (obj) -> Bool in
            return obj.equals(with: delegate)
        }) {
            self.delegates.remove(at: index)
        }
    }
}

let GlobalNetworkController = NetworkController()
