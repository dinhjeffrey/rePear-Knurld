//
//  DoneVC.swift
//  rePear
//
//  Created by Sara Du on 6/30/16.
//  Copyright © 2016 Sara Du. All rights reserved.
//

import UIKit

class DoneVC: UIViewController {

    @IBAction func donePressed(sender: AnyObject) {
        self.performSegueWithIdentifier("finished", sender: self)
    }
}
