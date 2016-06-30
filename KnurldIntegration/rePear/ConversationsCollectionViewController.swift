//
//  ConversationsCollectionViewController.swift
//  rePear
//
//  Created by Sara Du on 5/19/16.
//  Copyright © 2016 Sara Du. All rights reserved.
//

import UIKit


class ConversationsCollectionViewController: UICollectionViewController {

    let names = ["blueberry.png", "lemon.png", "apple.png", "avocado.png"]
    let seguenames = ["Chat", "Trigger", "Warning", "Motivation"]
    let boxnames = ["GENERAL SUPPORT", "TRIGGERS", "WARNING SIGNS", "MOTIVATION"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MotivationMessageFactory.messageindex = 0
        WarningMessageFactory.messageindex = 0
        ChatMessageFactory.messageindex = 0
        TriggerMessageFactory.messageindex = 0
        
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
        WarningMessageFactory.messageindex = 0
        TriggerMessageFactory.messageindex = 0
        MotivationMessageFactory.messageindex = 0
        ChatMessageFactory.messageindex = 0
        
        self.collectionView!.registerNib(UINib(nibName: "Box", bundle: nil), forCellWithReuseIdentifier: "cell")
        self.collectionView!.backgroundColor = UIColor.whiteColor()
        self.collectionView!.backgroundColor = UIColor(patternImage: UIImage(named:"blurback")!)
       
    }
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 4
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let cell : Box = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! Box
        
        // Configure the cell
        cell.appimage.image = UIImage(named: names[indexPath.row])
        cell.name.text = boxnames[indexPath.row]
        return cell
        
    }
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier(seguenames[indexPath.row], sender: self)
        /*
        let pageSize = 50
        let initialCount = 1
        if(indexPath.row == 0){
            let vc = Trigger()
            let dataSource = FakeDataSource(count: initialCount, pageSize: pageSize, version: "Trigger")
            vc.dataSource = dataSource
            vc.messageSender = dataSource.messageSender
            self.presentViewController(vc, animated: false, completion: nil)
        }else if(indexPath.row == 1){
            let vc = WarningSigns()
            let dataSource = FakeDataSource(count: initialCount, pageSize: pageSize, version: "Warning")
            vc.dataSource = dataSource
            vc.messageSender = dataSource.messageSender
            self.presentViewController(vc, animated: false, completion: nil)
        }else if(indexPath.row == 2){
            let vc = Motivation()
            let dataSource = FakeDataSource(count: initialCount, pageSize: pageSize, version: "Motivation")
            vc.dataSource = dataSource
            vc.messageSender = dataSource.messageSender
            self.presentViewController(vc, animated: false, completion: nil)
        }else{
            let vc = GeneralChat()
            let dataSource = FakeDataSource(count: initialCount, pageSize: pageSize, version: "Chat")
            vc.dataSource = dataSource
            vc.messageSender = dataSource.messageSender
            self.presentViewController(vc, animated: false, completion: nil)

        }
*/
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var initialCount = 0
        let pageSize = 50
        
        var dataSource: FakeDataSource!
        if segue.identifier != "" {
            initialCount = 1
        }else {
            assert(false, "segue not handled!")
        }
        
        if(segue.identifier == "Warning"){
            let chatController = segue.destinationViewController as! WarningSigns
            if dataSource == nil {
                dataSource = FakeDataSource(count: initialCount, pageSize: pageSize, version: "Warning")
            }
            chatController.hidesBottomBarWhenPushed = true
            chatController.dataSource = dataSource
            chatController.messageSender = dataSource.messageSender
        }else if(segue.identifier == "Trigger"){
            let VC = segue.destinationViewController as! Trigger
            if dataSource == nil {
                dataSource = FakeDataSource(count: initialCount, pageSize: pageSize, version: "Trigger")
            }
            VC.hidesBottomBarWhenPushed = true
            VC.dataSource = dataSource
            VC.messageSender = dataSource.messageSender
        }
        else if(segue.identifier == "Motivation"){
            let VC = segue.destinationViewController as! Motivation
            if dataSource == nil {
                dataSource = FakeDataSource(count: initialCount, pageSize: pageSize, version: "Motivation")
            }
            VC.hidesBottomBarWhenPushed = true
            VC.dataSource = dataSource
            VC.messageSender = dataSource.messageSender
        }
        else if(segue.identifier == "Chat"){
            let VC = segue.destinationViewController as! GeneralChat
            if dataSource == nil {
                dataSource = FakeDataSource(count: initialCount, pageSize: pageSize, version: "Chat")
            }
            VC.hidesBottomBarWhenPushed = true
            VC.dataSource = dataSource
            VC.messageSender = dataSource.messageSender
        }
        
        
    }
    

}

