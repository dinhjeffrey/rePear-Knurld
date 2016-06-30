//
//  MapDetailViewController.swift
//  rePear
//
//  Created by Sara Du on 5/22/16.
//  Copyright © 2016 Sara Du. All rights reserved.
//

import UIKit
import MapKit
import EventKitUI

class MapDetailViewController: UIViewController, MKMapViewDelegate{

    @IBOutlet weak var locationnamelabel: UILabel!
    @IBOutlet weak var contactlabel: UILabel!
    @IBOutlet weak var dateslabel: UILabel!
    @IBOutlet weak var timeslabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    var passnumber = 0
    var name = ""
    var coordinate = CLLocationCoordinate2D()
    var location = ""
    var date = ""
    var time = ""
    var contact = ""
    var updatedRegion = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        locationnamelabel.text = location
        contactlabel.text = contact
        dateslabel.text = date
        timeslabel.text = time
        self.navigationItem.title = name
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = name
        mapView.addAnnotation(annotation)
        mapView.reloadInputViews()
        
        let center = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.8, longitudeDelta: 0.8))
        
        
        if(updatedRegion == false){
            mapView.setRegion(region, animated: true)
            updatedRegion = true
        }

    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        var pin = mapView.dequeueReusableAnnotationViewWithIdentifier("pin")
        if(pin == nil){
            pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        }
        return pin
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func savePressed(sender: AnyObject) {
        let vc = NativeEventFormViewController()
        vc.alttitle = name
        vc.altlocation = location
        vc.altcontactperson = contact
        vc.altstartdate = date
        vc.altstarttime = time
        let navigationControllerAtTabIndex1: UINavigationController = self.tabBarController?.viewControllers![0] as! UINavigationController
        // Push formPage1 view controller on the middle tab's navigation controller stack
        navigationControllerAtTabIndex1.pushViewController(vc, animated: true)
        // Set the selected view controller to the middle tab's navigation controller
        self.tabBarController!.selectedViewController = self.tabBarController!.viewControllers![0]

        
        /*
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewControllerWithIdentifier("calendarroot") as! UINavigationController
        viewController.pushViewController(vc, animated: true)
        */
        
        //self.presentViewController(vc, animated: true, completion: nil)
    }
    
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        //let viewController = mainStoryboard.instantiateViewControllerWithIdentifier("calendarroot") as! UINavigationController
        //UIApplication.sharedApplication().keyWindow?.rootViewController = viewController;
        let vc = segue.destinationViewController as! NativeEventFormViewController
        vc.alttitle = name
        vc.altlocation = location
        vc.altcontactperson = contact
        vc.altstarts = date
    }
*/
    @IBAction func aPressed(sender: AnyObject) {
        passnumber = 3

         self.performSegueWithIdentifier("profile", sender: self)
    }
    @IBAction func bPressed(sender: AnyObject) {
        passnumber = 0
        self.performSegueWithIdentifier("profile", sender: self)
    }
    @IBAction func wPressed(sender: AnyObject) {
        passnumber = 2
         self.performSegueWithIdentifier("profile", sender: self)
    }
    @IBAction func sPressed(sender: AnyObject) {
        passnumber = 1
        self.performSegueWithIdentifier("profile", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! ProfileViewController
        vc.number = passnumber
    }

}
