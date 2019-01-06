//
//  APITwitterDelegate.swift
//  d04
//
//  Created by Vyacheslav GLADUSH on 05.10.2018.
//  Copyright © 2018 Vyacheslav GLADUSH. All rights reserved.
//

import Foundation


protocol APITwitterDelegate {
    func apiTwitter (name: [Tweet])
    func error(er: NSError)
}
