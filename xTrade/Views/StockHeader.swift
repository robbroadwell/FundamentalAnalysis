//
//  StockHeader.swift
//  xTrade
//
//  Created by Rob Broadwell on 6/18/18.
//  Copyright © 2018 Rob Broadwell. All rights reserved.
//

import UIKit

class StockHeader: UIView {
    class func instanceFromNib() -> StockHeader {
        return UINib(nibName: "StockHeader", bundle: Bundle.main).instantiate(withOwner: nil, options: nil)[0] as! StockHeader
    }
}
