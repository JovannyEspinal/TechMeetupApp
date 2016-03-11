//
//  NSDate+ConvertToString.swift
//  TechMeetup
//
//  Created by Jovanny Espinal on 3/11/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation

extension NSDate {
    func convertToString() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale.currentLocale()
        dateFormatter.dateFormat = "EEEE, MMMM, dd, yyyy hh:mma"
        
        let dateString = dateFormatter.stringFromDate(self)
        
        return dateString
    }
}