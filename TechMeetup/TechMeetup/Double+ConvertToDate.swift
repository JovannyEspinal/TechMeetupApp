//
//  Double+ConvertToDate.swift
//  TechMeetup
//
//  Created by Jovanny Espinal on 3/11/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation

extension Double {
    func convertToDate() -> NSDate
    {
        let timeInterval: NSTimeInterval = self/1000
        
        let date = NSDate(timeIntervalSince1970: timeInterval)
        
        return date
    }
}