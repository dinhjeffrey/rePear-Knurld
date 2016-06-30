//
//  AddEvent.swift
//  Malendar
//
//  Created by Chase Roossin on 10/20/15.
//  Copyright © 2015 Smart Drive LLC. All rights reserved.
//

import Foundation
import UIKit
import EventKitUI

//To add an event
class NativeEventNavigationController: UINavigationController, RowControllerType {
    var completionCallback : ((UIViewController) -> ())?
    
    
}

class NativeEventFormViewController : FormViewController {
    
    
    var defaultCalendar: EKCalendar!
    var eventStore: EKEventStore!
    var eventTitle: String =  ""
    var eventLocation: String = ""
    var eventAllday: Bool = false
    var eventStart: NSDate = NSDate()
    var eventEnd: NSDate = NSDate()
    var eventNotes: String = ""
    
    var alttitle = ""
    var altlocation = ""
    var altstartdate = ""
    var altstarttime = ""
    var altcontactperson = ""
    
    var times = [String]()
    var hours = [String]()
    var minutes = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(altstarttime != ""){
        times = altstarttime.componentsSeparatedByString(" - ")
        
            if times.count > 1{
            hours.append((times[1] as NSString).substringToIndex(1))
            minutes.append(times[1].substringWithRange(Range<String.Index>(start: times[1].startIndex.advancedBy(2), end: times[1].startIndex.advancedBy(3))))
            }
            hours.insert((times[0] as NSString).substringToIndex(1), atIndex: 0)
            minutes.insert(times[0].substringWithRange(Range<String.Index>(start: times[0].startIndex.advancedBy(2), end: times[0].startIndex.advancedBy(4))), atIndex: 0)
            let newrightbutton = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: "addEvent:")
            self.navigationItem.rightBarButtonItem = newrightbutton
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
            self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        }
        self.navigationItem.leftBarButtonItem?.target = self
        self.navigationItem.leftBarButtonItem?.action = "cancelTapped:"
        
        self.navigationItem.rightBarButtonItem?.target = self
        self.navigationItem.rightBarButtonItem?.action = "addEvent:"
        
        initializeForm()
        // Initialize the event store
        self.eventStore = EKEventStore()
        self.checkEventStoreAccessForCalendar()
    }
    
    
    private func initializeForm() {

        form =
            
        
            TextRow("Title").cellSetup { cell, row in
                cell.textField.placeholder = row.tag
                if(self.alttitle != ""){
                    row.value = self.alttitle
                    cell.textField.text = self.alttitle
                }
                }.onChange { [weak self] row in
                    let inputTitle = row.value as String?
                    if(inputTitle != nil){
                        self!.eventTitle = row.value as String!
                    }else{
                        self!.eventTitle = ""
                    }
                    
            }
            
            
            <<< TextRow("Location").cellSetup {
                $0.cell.textField.placeholder = $0.row.tag
                if(self.alttitle != ""){
                    $0.row.value = self.altlocation
                }
                }.onChange { [weak self] row in
                    let inputTitle = row.value as String?
                    if(inputTitle != nil){
                        self!.eventLocation = row.value as String!
                    }else{
                        self!.eventLocation = ""
                    }
            }
            
            +++
            
            SwitchRow("All-day") {
                $0.title = $0.tag
                }.onChange { [weak self] row in
                    let startDate: DateTimeInlineRow! = self?.form.rowByTag("Starts")
                    let endDate: DateTimeInlineRow! = self?.form.rowByTag("Ends")
                    
                    if row.value ?? false {
                        startDate.dateFormatter?.dateStyle = .MediumStyle
                        startDate.dateFormatter?.timeStyle = .NoStyle
                        endDate.dateFormatter?.dateStyle = .MediumStyle
                        endDate.dateFormatter?.timeStyle = .NoStyle
                    }
                    else {
                        startDate.dateFormatter?.dateStyle = .ShortStyle
                        startDate.dateFormatter?.timeStyle = .ShortStyle
                        endDate.dateFormatter?.dateStyle = .ShortStyle
                        endDate.dateFormatter?.timeStyle = .ShortStyle
                    }
                    startDate.updateCell()
                    endDate.updateCell()
                    startDate.inlineRow?.updateCell()
                    endDate.inlineRow?.updateCell()
                    self!.eventAllday = row.value as Bool!
            }
            
            <<< DateTimeInlineRow("Starts") {
                $0.title = $0.tag
                $0.value = NSDate().dateByAddingTimeInterval(60*60*24)
                if(self.altstartdate != ""){
                    var today: NSDate = NSDate()
                    var gregorian: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
                    gregorian.locale = NSLocale.currentLocale()
                    let nowComponents: NSDateComponents = gregorian.components([.Day, .Month, .Year, .Weekday], fromDate: today)
                    
                    var add = 0
                    if(self.altstartdate == "Monday"){
                        add = 2
                    }
                    if(self.altstartdate == "Tueday"){
                        add = 3
                    }
                    if(self.altstartdate == "Wednesday"){
                        add = 4
                    }
                    if(self.altstartdate == "Thursday"){
                        add = 5
                    }
                    if(self.altstartdate == "Friday"){
                        add = 6
                    }
                    if(self.altstartdate == "Saturday"){
                        add = 7
                    }
                    if(self.altstartdate == "Sunday"){
                        add = 1
                    }
                    
                    let newday = NSDate().dateByAddingTimeInterval(Double(60 * 60 * 24 * abs(nowComponents.weekday - add)))
                    nowComponents.day = nowComponents.day + add
                    
                    nowComponents.hour = Int(self.hours.first!)! + 12
                    nowComponents.minute = Int(self.minutes.first!)!
                    
                    var finaldate = gregorian.dateFromComponents(nowComponents)
                    $0.value = finaldate
                }
                }
                .onChange { [weak self] row in
                    let endRow: DateTimeInlineRow! = self?.form.rowByTag("Ends")
                    if row.value?.compare(endRow.value!) == .OrderedDescending {
                        endRow.value = NSDate(timeInterval: 60*60*24, sinceDate: row.value!)
                        endRow.cell!.backgroundColor = .whiteColor()
                        endRow.updateCell()
                    }
                    self!.eventStart = row.value as NSDate!
                }
                .onExpandInlineRow { cell, row, inlineRow in
                    inlineRow.cellUpdate { [weak self] cell, dateRow in
                        let allRow: SwitchRow! = self?.form.rowByTag("All-day")
                        if allRow.value ?? false {
                            cell.datePicker.datePickerMode = .Date
                        }
                        else {
                            cell.datePicker.datePickerMode = .DateAndTime
                        }
                    }
                    let color = cell.detailTextLabel?.textColor
                    row.onCollapseInlineRow { cell, _, _ in
                        cell.detailTextLabel?.textColor = color
                    }
                    cell.detailTextLabel?.textColor = cell.tintColor
                    
            }
            
            <<< DateTimeInlineRow("Ends"){
                $0.title = $0.tag
                $0.value = NSDate().dateByAddingTimeInterval(60*60*25)
                if(self.altstartdate != ""){
                    var today: NSDate = NSDate()
                    var gregorian: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
                    gregorian.locale = NSLocale.currentLocale()
                    var nowComponents: NSDateComponents = gregorian.components([.Day, .Month, .Year], fromDate: today)
                    nowComponents.weekday = 2
                    
                    if(self.hours.count == 1){
                        nowComponents.hour = Int(self.hours.first!)! + 12
                        nowComponents.minute = Int(self.minutes.first!)!
                    }else{
                        nowComponents.hour = Int(self.hours[1])! + 12
                        nowComponents.minute = Int(self.minutes[1])!
                    }
                    var finaldate = gregorian.dateFromComponents(nowComponents)
                    $0.value = finaldate
                }
                
                }
                .onChange { [weak self] row in
                    let startRow: DateTimeInlineRow! = self?.form.rowByTag("Starts")
                    if row.value?.compare(startRow.value!) == .OrderedAscending {
                        row.cell!.backgroundColor = .redColor()
                    }
                    else{
                        row.cell!.backgroundColor = .whiteColor()
                    }
                    row.updateCell()
                    self!.eventEnd = row.value as NSDate!
                }
                .onExpandInlineRow { cell, row, inlineRow in
                    inlineRow.cellUpdate { [weak self] cell, dateRow in
                        let allRow: SwitchRow! = self?.form.rowByTag("All-day")
                        if allRow.value ?? false {
                            cell.datePicker.datePickerMode = .Date
                        }
                        else {
                            cell.datePicker.datePickerMode = .DateAndTime
                        }
                    }
                    let color = cell.detailTextLabel?.textColor
                    row.onCollapseInlineRow { cell, _, _ in
                        cell.detailTextLabel?.textColor = color
                    }
                    cell.detailTextLabel?.textColor = cell.tintColor
        }
        
        form +++=
            
            TextAreaRow("notes") {
                
                $0.placeholder = "Notes"
                if(self.alttitle != ""){
                    $0.cell.row.value = "Contact: " + self.altcontactperson
                }
                }.onChange { [weak self] row in
                    let inputTitle = row.value as String?
                    if(inputTitle != nil){
                        self!.eventNotes = row.value as String!
                    }else{
                        self!.eventNotes = ""
                    }
                    
        }
        
    }
    
    func cancelTapped(barButtonItem: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addEvent(barButtonItem: UIBarButtonItem) {
        if(eventTitle == ""){
            let alertView = SCLAlertView()
            alertView.showCloseButton = true
            alertView.showWarning("Title", subTitle: "Please include at least an event title.")
        }else{
            let event:EKEvent = EKEvent(eventStore: eventStore)
            
            event.title = eventTitle
            event.startDate = eventStart
            event.endDate = eventEnd
            event.notes = eventNotes
            event.allDay = eventAllday
            event.location = eventLocation
            event.calendar = eventStore.defaultCalendarForNewEvents
            do{
                try self.eventStore.saveEvent(event, span: .ThisEvent)
                
            }catch{
                print(error)
            }
            print("Saved Event")
            let alert = UIAlertController(title: "Saved", message: "Event has been saved to calendar!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    enum RepeatInterval : String, CustomStringConvertible {
        case Never = "Never"
        case Every_Day = "Every Day"
        case Every_Week = "Every Week"
        case Every_2_Weeks = "Every 2 Weeks"
        case Every_Month = "Every Month"
        case Every_Year = "Every Year"
        
        var description : String { return rawValue }
        
        static let allValues = [Never, Every_Day, Every_Week, Every_2_Weeks, Every_Month, Every_Year]
    }
    
    enum EventAlert : String, CustomStringConvertible {
        case Never = "None"
        case At_time_of_event = "At time of event"
        case Five_Minutes = "5 minutes before"
        case FifTeen_Minutes = "15 minutes before"
        case Half_Hour = "30 minutes before"
        case One_Hour = "1 hour before"
        case Two_Hour = "2 hours before"
        case One_Day = "1 day before"
        case Two_Days = "2 days before"
        
        var description : String { return rawValue }
        
        static let allValues = [Never, At_time_of_event, Five_Minutes, FifTeen_Minutes, Half_Hour, One_Hour, Two_Hour, One_Day, Two_Days]
    }
    
    enum EventState {
        case Busy
        case Free
        
        static let allValues = [Busy, Free]
    }
    
    // Check the authorization status of our application for Calendar
    private func checkEventStoreAccessForCalendar() {
        let status = EKEventStore.authorizationStatusForEntityType(EKEntityType.Event)
        
        switch status {
            // Update our UI if the user has granted access to their Calendar
        case .Authorized: self.defaultCalendar = self.eventStore.defaultCalendarForNewEvents
            // Prompt the user for access to Calendar if there is no definitive answer
        case .NotDetermined: self.requestCalendarAccess()
            // Display a message if the user has denied or restricted access to Calendar
        case .Denied, .Restricted:
            print("denied")
        }
    }
    
    // Prompt the user for access to their Calendar
    private func requestCalendarAccess() {
        self.eventStore.requestAccessToEntityType(.Event) {[weak self] granted, error in
            if granted {
                // Let's ensure that our code will be executed from the main queue
                dispatch_async(dispatch_get_main_queue()) {
                    // The user has granted access to their Calendar; let's populate our UI with all events occuring in the next 24 hours.
                    self?.accessGrantedForCalendar()
                }
            }
        }
    }
    
    // This method is called when the user has granted permission to Calendar
    private func accessGrantedForCalendar() {
        // Let's get the default calendar associated with our event store
        self.defaultCalendar = self.eventStore.defaultCalendarForNewEvents
    }
}
