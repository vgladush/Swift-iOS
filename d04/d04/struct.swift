//
//  struct.swift
//  d04
//
//  Created by Vyacheslav GLADUSH on 05.10.2018.
//  Copyright © 2018 Vyacheslav GLADUSH. All rights reserved.
//

import Foundation


struct  Tweet : CustomStringConvertible {
    let name : String
    let text : String
    let date : String
    
    public var views : String {
        return ("\(name)\n\(date)\n\(text)")
    }
}
