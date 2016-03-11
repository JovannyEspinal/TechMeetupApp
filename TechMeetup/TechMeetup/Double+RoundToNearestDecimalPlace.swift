//
//  Double+RoundToNearestDecimalPlace.swift
//  TechMeetup
//
//  Created by Jovanny Espinal on 3/11/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation

extension Double {
    func roundToPlaces(places:Int) -> Double
    {
        let divisor = pow(10.0, Double(places))
        return round(self * divisor) / divisor
    }
}
