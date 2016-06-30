//
//  ProfileViewController.swift
//  rePear
//
//  Created by Sara Du on 5/26/16.
//  Copyright © 2016 Sara Du. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var accomplishmentsText: UILabel!
    @IBOutlet weak var adviceText: UILabel!
    
    var number = 0
    var names = ["Bill", "Sally", "William", "Adam"]
    var images = ["blueberry", "strawberry", "watermelon", "apple"]
    var locations = ["Williamsburg, VA", "New York, NY", "Los Angeles, CA", "Atlanta, GA"]
    var advices = ["Never ever give up! Even when times are toughest, that's when you have to be the strongest", "Believe in yourself! Have faith in your abilities! Without a humble but reasonable confidence in your own powers you cannot be successful or happy.", "Our greatest weakness lies in giving up. The most certain way to succeed is always to try just one more time.", "Keep your eyes on the stars, and your feet on the ground."]
    var achievements = ["I at ten slices of pizza yesterday!", "I finally got a job after two years of unemployment :D", "I got a pay raise because of my improved work ethic ^.^", "I won first place at a taekwondo tournament!"]
    override func viewDidLoad() {
        locationLabel.text = locations[number]
        avatar.image = UIImage(named: images[number])
        if(number == 2){
            avatar.contentMode = .ScaleAspectFit
        }
        nameLabel.text = names[number]
        accomplishmentsText.text = achievements[number]
        adviceText.text = advices[number]
    }

    @IBAction func addPressed(sender: AnyObject) {
        let alert = UIAlertController(title: "New Friend", message: "You've added \(names[number]) to your friend list!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)

    }
   
    @IBAction func chatPressed(sender: AnyObject) {
        let alert = UIAlertController(title: "Coming Soon", message: "This feature will be added in the future!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)

    }
}
