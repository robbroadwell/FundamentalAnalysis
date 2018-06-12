//
//  NetworkDelegate.swift
//  xTrade
//
//  Created by Rob Broadwell on 6/12/18.
//  Copyright © 2018 Rob Broadwell. All rights reserved.
//

import Foundation

protocol NetworkDelegate {
    func networkManager(didFinishTaskFor endpoint: NetworkDataEndpoint, with data: Data)
    func networkManager(didFinishTaskFor endpoint: NetworkDataEndpoint, with error: Error)
}

extension NetworkDelegate {
    func equals(with delegate: NetworkDelegate) -> Bool {
        return Unmanaged<AnyObject>.passUnretained(self as AnyObject).toOpaque() == Unmanaged<AnyObject>.passUnretained(delegate as AnyObject).toOpaque()
    }
}
