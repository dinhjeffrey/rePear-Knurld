//
//  MapViewController.swift
//  rePear
//
//  Created by Sara Du on 5/22/16.
//  Copyright © 2016 Sara Du. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var map: MKMapView!
    var locations = [CLLocationCoordinate2D]()
    var locationnames = [String]()
    var meetingnames = [String]()
    var contactinfo = [String]()
    var dates = [String]()
    var times = [String]()
    var currentdetailname = ""
    var currdate = ""
    var currtime = ""
    var currcontact = ""
    var currlocation = ""
    var currcoordinate = CLLocationCoordinate2D()
    
    var locationManager: CLLocationManager!
    var updatedRegion = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "MapCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        map.showsUserLocation = true
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        self.getNearby()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meetingnames.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        currentdetailname = meetingnames[indexPath.row]
        currtime = times[indexPath.row]
        currcontact = contactinfo[indexPath.row]
        currdate = dates[indexPath.row]
        currlocation = locationnames[indexPath.row]
        currcoordinate = locations[indexPath.row]
        self.performSegueWithIdentifier("mapdetail", sender: self)
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! MapCell
        cell.dateLabel.text = dates[indexPath.row]
        cell.timeLabel.text = times[indexPath.row]
        cell.nameLabel.text = meetingnames[indexPath.row]
        cell.locationLabel.text = locationnames[indexPath.row]

        return cell
    }
    
    func getNearby(){
       
        if let path = NSBundle.mainBundle().pathForResource("groups", ofType: "json") {
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    for index in 1...jsonObj.count{
                        let name = jsonObj[index-1]["locationname"].rawString()!
                        let splitmeetingname = jsonObj[index-1]["name"].rawString()!.characters.split{$0 == "/"}.map(String.init)
                        let contact = jsonObj[index-1]["contact"].rawString()!
                        let splitdate = jsonObj[index-1]["dates"].rawString()!.characters.split{$0 == "/"}.map(String.init)
                        let splittime = jsonObj[index-1]["times"].rawString()!.characters.split{$0 == "/"}.map(String.init)
                        for i in 0...splitdate.count-1{
                            locationnames.append(name)
                            meetingnames.append(splitmeetingname[i])
                            contactinfo.append(contact)
                            dates.append(splitdate[i])
                            times.append(splittime[i])
                            let lat = jsonObj[index-1]["latitude"].rawValue as! CLLocationDegrees
                            let long = jsonObj[index-1]["longitude"].rawValue as! CLLocationDegrees
                            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                            locations.append(coordinate)
                            
                            let annotation = MKPointAnnotation()
                            annotation.coordinate = coordinate
                            annotation.title = jsonObj[index-1]["name"].rawString()!
                            map.addAnnotation(annotation)
                        }
                        
                        
                    }
                    map.reloadInputViews()
 
                    
                } else {
                    print("could not get json from file, make sure that file contains valid json.")
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }

    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       
        let location = locations.last
        //replace later to user location
        let center = CLLocationCoordinate2D(latitude: 38.9072, longitude: -77.0369)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.8, longitudeDelta: 0.8))
        
        
        if(updatedRegion == false){
            map.setRegion(region, animated: true)
            updatedRegion = true
        }

    }
    
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        var pin = map.dequeueReusableAnnotationViewWithIdentifier("pin")
        if(pin == nil){
            pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        }
        return pin
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "mapdetail"){
        let vc = segue.destinationViewController as! MapDetailViewController
        vc.navigationItem.title = currentdetailname
        vc.date = currdate
        vc.time = currtime
        vc.contact = currcontact
        vc.location = currlocation
        vc.name = currentdetailname
        vc.coordinate = currcoordinate
        }
    }
    
    
}
