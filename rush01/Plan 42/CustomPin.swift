//
//  CustomPin.swift
//  Plan 42
//
//  Created by Yaroslav Zakharchuk on 10/14/18.
//  Copyright © 2018 Yaroslav Zakharchuk. All rights reserved.
//

import UIKit
import MapKit

class CustomPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(pinTitle: String, pinSubTitle: String, location: CLLocationCoordinate2D) {
        self.title = pinTitle
        self.subtitle = pinSubTitle
        self.coordinate = location
    }
}
