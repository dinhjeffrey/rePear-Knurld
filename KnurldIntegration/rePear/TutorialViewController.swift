//
//  TutorialViewController.swift
//  rePear
//
//  Created by Sara Du on 6/29/16.
//  Copyright © 2016 Sara Du. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {
    
    @IBOutlet weak var startLabel: UILabel!
   // @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var containerView: UIView!
    var hideButton = true
    
    var tutorialPageViewController: TutorialPageViewController? {
        didSet {
            tutorialPageViewController?.tutorialDelegate = self
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        
        startLabel.hidden = true
        pageControl.addTarget(self, action: "didChangePageControlValue", forControlEvents: .ValueChanged)
    
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let tutorialPageViewController = segue.destinationViewController as? TutorialPageViewController {
            self.tutorialPageViewController = tutorialPageViewController
        }
    }
    
    @IBAction func micPressed(sender: AnyObject) {
        if(startLabel.hidden == false){
            startLabel.text = "Done!"
            startLabel.hidden = true
            tutorialPageViewController!.lastPage = true
        }
        if(pageControl.currentPage == 1){
            startLabel.hidden = false
        }
        
    }
    
    /*
    @IBAction func donePressed(sender: AnyObject) {
        if(pageControl.currentPage == 1){
            tutorialPageViewController!.lastPage = true
        }
    }
*/
    /*
    @IBAction func didTapNextButton(sender: UIButton) {
        tutorialPageViewController?.scrollToNextViewController()
    }
    */
    
    /**
     Fired when the user taps on the pageControl to change its current page.
     */
    func didChangePageControlValue() {
        tutorialPageViewController?.scrollToViewController(index: pageControl.currentPage)
    }
}

extension TutorialViewController: TutorialPageViewControllerDelegate {
    
    func tutorialPageViewController(tutorialPageViewController: TutorialPageViewController,
        didUpdatePageCount count: Int) {
            pageControl.numberOfPages = count
    }
    
    func tutorialPageViewController(tutorialPageViewController: TutorialPageViewController,
        didUpdatePageIndex index: Int) {
            pageControl.currentPage = index
    }
    
}