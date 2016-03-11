//
//  Meetup.swift
//  TechMeetup
//
//  Created by Jovanny Espinal on 3/9/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation
import SwiftyJSON

class Meetup {
    let distance: Double
    let meetupName: String
    let groupName: String
    let time: Double
    let attending: Int
    let waitlistCount: Int
    
    class func meetupsFromJSON(json: JSON) -> [Meetup]?
    {
        var tempMeetups = [Meetup]()
        
        if let results = json["results"].array {
            
            for i in 0..<results.count {
                
                let groupName = results[i]["group"]["name"].string!
                
                let meetupName = results[i]["name"].string!
                
                let time = results[i]["time"].double!
                
                let distance = results[i]["distance"].double!.roundToPlaces(1)
                
                let waitlistCount = results[i]["waitlist_count"].int!
                
                let attending = results[i]["yes_rsvp_count"].int!
                
                let meetup = Meetup.init(distance: distance, meetupName: meetupName, groupName: groupName, time: time, attending: attending, waitlistCount: waitlistCount)
                
                tempMeetups.append(meetup)
            }
        }
        
        let meetups = tempMeetups.sort({ $1.time > $0.time })
        
        return meetups
    }
    
    init(distance: Double, meetupName: String, groupName: String, time: Double, attending: Int, waitlistCount: Int)
    {
        self.distance = distance
        self.meetupName = meetupName
        self.groupName = groupName
        self.time = time
        self.attending = attending
        self.waitlistCount = waitlistCount
        
    }
}