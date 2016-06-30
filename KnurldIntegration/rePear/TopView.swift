//
//  TopView.swift
//  ZYThumbnailTableView
//
//  Created by lzy on 16/2/14.
//  Copyright © 2016年 lzy. All rights reserved.
//

import UIKit


@objc protocol DiyTopViewDelegate {
    optional func topViewDidClickFavoriteBtn(topView: TopView)
    optional func topViewDidClickMarkAsReadButton(topView: TopView)
    optional func topViewDidClickShareBtn(topView: TopView)
}

//selected A7DA55
//default  AAAAAA
class TopView: UIView {
    
    
    @IBOutlet weak var readMarkingButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    let TAG_BUTTON_GENERAL = 10
    let TAG_BUTTON_SELECTED = 20
    
    let COLOR_SELECTED = UIColor(red: 167/255.0, green: 218/255.0, blue: 85/255.0, alpha: 1.0)
    let COLOR_NORMAL = UIColor(red: 170/255.0, green: 170/255.0, blue: 170/255.0, alpha: 1.0)
    
    var indexPath: NSIndexPath!
    var delegate: DiyTopViewDelegate?

    class func createView(indexPath: NSIndexPath, post: Post) -> TopView? {
        let view = NSBundle.mainBundle().loadNibNamed("TopView", owner: nil, options: nil).first as? TopView
        guard let nonNilView = view else {
            assertionFailure("ERROR: can not load nib \"TopView\"")
            return nil
        }
        nonNilView.indexPath = indexPath
        nonNilView.configureComponents(post)
        return nonNilView
    }
    
    func configureComponents(post: Post) {
        //-----收藏
        if post.favorite {
            favoriteButton.setImage(UIImage(named: "star_solid"), forState: .Normal)
            favoriteButton.setTitleColor(COLOR_SELECTED, forState: .Normal)
            favoriteButton.tag = TAG_BUTTON_SELECTED
        } else {
            favoriteButton.setImage(UIImage(named: "star_hollow"), forState: .Normal)
            favoriteButton.setTitleColor(COLOR_NORMAL, forState: .Normal)
            favoriteButton.tag = TAG_BUTTON_GENERAL
        }
        
        //-----已读
        if post.read {
            //setimage
            readMarkingButton.setImage(UIImage(named: "tick_solid"), forState: .Normal)
            readMarkingButton.setTitleColor(COLOR_SELECTED, forState: .Normal)
            readMarkingButton.setTitle(" Mark as Unread", forState: .Normal)
            readMarkingButton.tag = TAG_BUTTON_SELECTED
        } else {
            //setimage
            readMarkingButton.setImage(UIImage(named: "tick_hollow"), forState: .Normal)
            readMarkingButton.setTitleColor(COLOR_NORMAL, forState: .Normal)
            readMarkingButton.setTitle(" Mark as Read", forState: .Normal)
            readMarkingButton.tag = TAG_BUTTON_GENERAL
        }
    }
    
    @IBAction func clickFavoriteButton(sender: UIButton) {
        if sender.tag == TAG_BUTTON_GENERAL {
            sender.setTitleColor(COLOR_SELECTED, forState: .Normal)
            sender.setImage(UIImage(named: "star_solid"), forState: .Normal)
            sender.tag = TAG_BUTTON_SELECTED
        } else if sender.tag == TAG_BUTTON_SELECTED {
            sender.setTitleColor(COLOR_NORMAL, forState: .Normal)
            sender.setImage(UIImage(named: "star_hollow"), forState: .Normal)
            sender.tag = TAG_BUTTON_GENERAL
        }
        
        //notification
        let notification = NSNotification(name: "NOTIFY_NAME_DISMISS_PREVIEW", object: nil)
        NSNotificationCenter.defaultCenter().performSelector("postNotification:", withObject: notification, afterDelay: 0.25)
        
        //delegate
        if let nonNilDelegate = delegate {
            nonNilDelegate.topViewDidClickFavoriteBtn?(self)
        }
    }
    
    
    @IBAction func clickMarkAsReadButton(sender: UIButton) {
        if sender.tag == TAG_BUTTON_GENERAL {
            sender.setTitleColor(COLOR_SELECTED, forState: .Normal)
            sender.setTitle(" Mark as Unread", forState: .Normal)
            sender.setImage(UIImage(named: "tick_solid"), forState: .Normal)
            sender.tag = TAG_BUTTON_SELECTED
        } else if sender.tag == TAG_BUTTON_SELECTED {
            sender.setTitleColor(COLOR_NORMAL, forState: .Normal)
            sender.setTitle(" Mark as Read", forState: .Normal)
            sender.setImage(UIImage(named: "tick_hollow"), forState: .Normal)
            sender.tag = TAG_BUTTON_GENERAL
        }
        
        //notification
        let notification = NSNotification(name: "NOTIFY_NAME_DISMISS_PREVIEW", object: nil)
        NSNotificationCenter.defaultCenter().performSelector("postNotification:", withObject: notification, afterDelay: 0.25)
        
        //delegate
        if let nonNilDelegate = delegate {
            nonNilDelegate.topViewDidClickMarkAsReadButton?(self)
        }
    }
    
    
    @IBAction func clickShareButton(sender: AnyObject) {
        defaults.setBool(true, forKey: "share")
        //notification
        
        let notification = NSNotification(name: "NOTIFY_NAME_DISMISS_PREVIEW", object: nil)
        NSNotificationCenter.defaultCenter().performSelector("postNotification:", withObject: notification, afterDelay: 0.25)
        
        //delegate
        if let nonNilDelegate = delegate {
            nonNilDelegate.topViewDidClickShareBtn?(self)
        }

    }
    
}
