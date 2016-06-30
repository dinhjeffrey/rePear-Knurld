//
//  FullTextViewController.swift
//  rePear
//
//  Created by Sara Du on 5/23/16.
//  Copyright © 2016 Sara Du. All rights reserved.
//

import UIKit

class FullTextViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var realtextView: UITextView!
    var texts = [""]
    var titles = [""]
    var index = 0
    //var textView = UITextView(frame: CGRectMake(0, 0, 370, 1200))

    override func viewDidLoad() {
        createDataSource()
        /*
        textView.font = UIFont(name: "Helvetica Neue", size: 12)
        textView.textAlignment = NSTextAlignment.Left
        textView.editable = false
        textView.scrollEnabled = true
        textView.text = texts[index]
        //textView.scrollRangeToVisible(NSMakeRange(0, 1))
        //textView.setContentOffset(CGPointZero, animated: false)
        textView.layoutManager.allowsNonContiguousLayout = false
        textView.scrollRangeToVisible(NSMakeRange(textView.text.characters.count-1, 0))
        textView.userInteractionEnabled = true
        self.view.addSubview(textView)
        */
        self.navigationItem.title = titles[index]

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    func createDataSource(){
        let dataSource = NSMutableArray()
        if let path = NSBundle.mainBundle().pathForResource("information", ofType: "json") {
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    let x = jsonObj.count
                    for index in 1...x{
                        texts.append(jsonObj[index-1]["text"].rawString()!)
                        titles.append(jsonObj[index-1]["title"].rawString()!)
                    }
                    titles.removeFirst()
                    texts.removeFirst()
                    
                    realtextView.text = texts[index]

                    
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
    
    
}
