//
//  customCell.swift
//  d05
//
//  Created by Vyacheslav GLADUSH on 09.10.2018.
//  Copyright © 2018 Vyacheslav GLADUSH. All rights reserved.
//

import Foundation
import UIKit

class customCell: UITableViewCell {
    
    @IBOutlet weak var placeLabel: UILabel!
    
    var location : (Double, Double, String, String, String)? {
        didSet {
            if let l = location {
                placeLabel?.text = l.2
            }
        }
    }
}
