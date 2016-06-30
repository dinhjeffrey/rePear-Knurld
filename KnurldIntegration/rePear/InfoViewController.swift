//
//  InfoViewController.swift
//  rePear
//
//  Created by Sara Du on 5/20/16.
//  Copyright © 2016 Sara Du. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController, ZYThumbnailTableViewControllerDelegate, DiyTopViewDelegate{
    
    var zyThumbnailTableVC: ZYThumbnailTableViewController!
    var dataList = NSArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNav()
        configureZYTableView()
    }
    
    func configureNav() {
        self.navigationController?.navigationBar.translucent = true
        let titleView = UILabel(frame: CGRectMake(0, 0, 200, 44))
        titleView.text = "Educational Material"
        titleView.textAlignment = .Center
        titleView.font = UIFont.systemFontOfSize(20.0);
        //503f39
        titleView.textColor = UIColor(red: 63/255.0, green: 47/255.0, blue: 41/255.0, alpha: 1.0)
        self.navigationItem.titleView = titleView
        
        /*
        let barItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Done, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = UIColor.grayColor()
        self.navigationItem.backBarButtonItem = barItem
        */
    }
    
    func configureZYTableView() {
        zyThumbnailTableVC = ZYThumbnailTableViewController()
       // zyThumbnailTableVC.tableViewCellReuseId = "DIYTableViewCell"
        zyThumbnailTableVC.tableViewCellHeight = 100.0
        //模拟创建一些数据作为演示
        dataList = createDataSource()
        //--------configure your diy tableview cell datalist
        zyThumbnailTableVC.tableViewDataList = dataList
        
        
        //--------insert your diy tableview cell
        zyThumbnailTableVC.configureTableViewCellBlock = {
            return DIYTableViewCell.createCell()
        }
        
        //--------update your cell here
        zyThumbnailTableVC.updateTableViewCellBlock =  { [weak self](cell: UITableViewCell, indexPath: NSIndexPath) -> Void in
            let myCell = cell as? DIYTableViewCell
            //Post is my data model
            guard let dataSource = self?.zyThumbnailTableVC.tableViewDataList[indexPath.row] as? Post else {
                print("ERROR: illegal tableview dataSource")
                return
            }
            myCell?.updateCell(dataSource)
        }
        
        //--------insert your diy TopView
        zyThumbnailTableVC.createTopExpansionViewBlock = { [weak self](indexPath: NSIndexPath) -> UIView in
            //Post is my data model
            let post = self?.zyThumbnailTableVC.tableViewDataList[indexPath.row] as! Post
            let topView = TopView.createView(indexPath, post: post)!
            topView.delegate = self;
            return topView
        }
        
        let diyBottomView = BottomView.createView()!
        //--------let your inputView component not cover by keyboard automatically (animated) (ZYKeyboardUtil)
        //全自动键盘遮盖处理
        zyThumbnailTableVC.keyboardAdaptiveView = diyBottomView.inputTextField;
        //--------insert your diy BottomView
        zyThumbnailTableVC.createBottomExpansionViewBlock = { _ in
            return diyBottomView
        }
        
        configureZYTableViewNav()
    }
    
    func configureZYTableViewNav() {
        let titleView = UILabel(frame: CGRectMake(0, 0, 200, 44))
        titleView.text = "Helpful Articles"
        titleView.textAlignment = .Center
        titleView.font = UIFont.systemFontOfSize(20.0);
        //503f39
        titleView.textColor = UIColor(red: 63/255.0, green: 47/255.0, blue: 41/255.0, alpha: 1.0)
        zyThumbnailTableVC.navigationItem.titleView = titleView
    }
    
    @IBAction func clickEnterButton(sender: AnyObject) {
        self.navigationController?.pushViewController(zyThumbnailTableVC, animated: true)
    }
      
    //MARK: delegate
    func zyTableViewDidSelectRow(tableView: UITableView, indexPath: NSIndexPath) {
        //        zyThumbnailTableVC.tableViewDataList[indexPath.row]
    }
    
    func topViewDidClickFavoriteBtn(topView: TopView) {
        let indexPath = topView.indexPath
        //Post is my data model
        let post = zyThumbnailTableVC.tableViewDataList[indexPath.row] as! Post
        post.favorite = !post.favorite
        zyThumbnailTableVC.reloadMainTableView()
    }
    
    func topViewDidClickMarkAsReadButton(topView: TopView) {
        let indexPath = topView.indexPath
        let post = zyThumbnailTableVC.tableViewDataList[indexPath.row] as! Post
        post.read = !post.read
        zyThumbnailTableVC.reloadMainTableView()
    }
    
    
    //此方法作用是虚拟出tableview数据源，不用理会
    //MARK: -Virtual DataSource
    func createDataSource() -> NSArray {
        let dataSource = NSMutableArray()
        var texts = [""]
        var titles = [""]
        if let path = NSBundle.mainBundle().pathForResource("information", ofType: "json") {
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.null {
                    let x = jsonObj.count
                    for index in 1...x{
                        let text = jsonObj[index-1]["text"].rawString()!
                        if(text.characters.count > 300){
                            let myString = text.substringWithRange(Range<String.Index>(start: text.startIndex.advancedBy(0), end: text.startIndex.advancedBy(300)))
                            texts.append(myString + "...")
                        }else{
                            texts.append(text)
                        }
                        titles.append(jsonObj[index-1]["title"].rawString()!)
                    }
                    
                    
                } else {
                    print("could not get json from file, make sure that file contains valid json.")
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }

        for index in 1...titles.count{
            var author = "SAMHSA"
            if(index <= 6){
                author = "Methadone.US"
            }
        
            dataSource.addObject([
                "name" : titles[index-1],
                "desc" : author,
                "time" : "",
                "content": texts[index-1],
                "favorite" : false,
                "read" : false
            ])
        }
        
        //remove empty spot
        dataSource.removeObjectAtIndex(0)
        
        //source dict to model
        let sourceDict = NSArray(array: dataSource)
        let postArray = NSMutableArray()
        for dict in sourceDict {
            let post = Post()
            let handleDict = dict as! Dictionary<String, AnyObject>
            post.name =  validStringForKeyFromDictionary("name", dict: handleDict)
            post.desc = validStringForKeyFromDictionary("desc", dict: handleDict)
            post.time = validStringForKeyFromDictionary("time", dict: handleDict)
            post.content = validStringForKeyFromDictionary("content", dict: handleDict)
            //post.avatar = validStringForKeyFromDictionary("avatar", dict: handleDict)
            post.favorite = handleDict["favorite"] as? Bool ?? false
            post.read = handleDict["read"] as? Bool ?? false
            postArray.addObject(post)
        }
        
        return NSArray(array: postArray)
    }
    
    
    func validStringForKeyFromDictionary(key: String, dict: Dictionary<String, AnyObject>) -> String {
        return dict[key] as? String ?? "illegal"
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}




//MARK: Model class
class Post: NSObject {
    
    var name: String = ""
    var avatar: String = ""
    var desc: String = ""
    var time: String = ""
    var content: String = ""
    var favorite: Bool = false
    var read: Bool = false
    
}
