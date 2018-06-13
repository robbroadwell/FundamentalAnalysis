//
//  DetailViewController.swift
//  xTrade
//
//  Created by Rob Broadwell on 6/12/18.
//  Copyright © 2018 Rob Broadwell. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController {
    
    var token: NotificationToken!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "6,421 Securities"
        
        token = GlobalDataController.stocks.observe { changes in
            // update tableview
        }
        
    }

}

