//
//  AFWrapper.swift
//  TechMeetup
//
//  Created by Jovanny Espinal on 3/9/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation

let meetupAPIKey = "20c261b781e441f3d56763e3266433"

class AFWrapper: NSObject {
    
    class func getJSONFromAPICall(location: CLLocation,  closure: (json : JSON) -> Void)
    {
        let meetupURL = "https://api.meetup.com/2/open_events?key=\(meetupAPIKey)&sign=true&photo-host=public&lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&topic=technology&page=20"
        
        Alamofire.request(.GET, meetupURL).validate().responseJSON { (response) -> Void in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    closure(json: json)
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
}


