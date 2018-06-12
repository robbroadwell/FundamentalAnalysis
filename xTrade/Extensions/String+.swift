//
//  String+.swift
//  xTrade
//
//  Created by Rob Broadwell on 6/12/18.
//  Copyright © 2018 Rob Broadwell. All rights reserved.
//

import Foundation

extension String {
    var lines: [String] {
        return split { String($0).rangeOfCharacter(from: .newlines) != nil }.map(String.init)
    }
}
