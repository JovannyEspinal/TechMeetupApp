//
//  TechMeetupsTableViewController.swift
//  TechMeetup
//
//  Created by Jovanny Espinal on 3/11/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import UIKit
import CoreLocation

class TechMeetupsTableViewController: UITableViewController {
    var meetups = [Meetup]()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        startLocationManager()
        configureNavigationBar()
        
    }
    
    func configureNavigationBar() {
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        navigationController!.navigationBar.tintColor = UIColor.whiteColor()
    }
}

// MARK: LocationManager Methods
extension TechMeetupsTableViewController {
    func startLocationManager()
    {
        locationManager.requestWhenInUseAuthorization()
        setupLocationManager()
    }
    
    func setupLocationManager()
    {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
}

// MARK: CLLocationManagerDelegate Methods
extension TechMeetupsTableViewController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        locationManager.stopUpdatingLocation()
        
        if let location = locations.first {
            AFWrapper.getJSONFromAPICall(location) { (json) -> Void in
                self.meetups = Meetup.meetupsFromJSON(json)!
                self.tableView.reloadData()
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        showAlertControllerWithError(error)
    }
}

// MARK: UIAlertController Configuration
extension TechMeetupsTableViewController {
    func showAlertControllerWithError(error: NSError)
    {
        let alertController = UIAlertController(title: "Location Search Failed", message: "Error: \(error)", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        
        let tryAgainAction = UIAlertAction(title: "Try Again", style: .Default) { (action) in
            self.locationManager.startUpdatingLocation()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(tryAgainAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}

// MARK: UITableViewDataSource Methods
extension TechMeetupsTableViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return meetups.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("MeetupCell", forIndexPath: indexPath) as! MeetupTableViewCell
        
        let meetup = meetups[indexPath.row]
        
        cell.groupNameLabel.text = meetup.groupName
        cell.meetupNameLabel.text = meetup.meetupName
        cell.distanceLabel.text = "\(meetup.distance) mi"
        cell.dateAndTimeLabel.text = meetup.time.convertToDate().convertToString()
        
        return cell
    }
}

// MARK: UITableViewDelegate Methods
extension TechMeetupsTableViewController {
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
}
