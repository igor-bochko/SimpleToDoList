//
//  ViewController.swift
//  SimpleToDoList
//
//  Created by HereTrix on 1/20/15.
//  Copyright (c) 2015 HereTrix. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {
    
    @IBOutlet weak var itemContent: UITextView!
    @IBOutlet var descriptionField: UITextField!
    @IBOutlet var scheduledDateButton: UIButton!
    @IBOutlet var itemColorButton: UIButton!
    @IBOutlet var datePickerHintField: UITextField!
    var scheduledDate: NSDate?
    
    var datePicker: UIDatePicker!
    
    var itemToSave: HTXToDoItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = UIDatePickerMode.DateAndTime
        datePicker.minimumDate = NSDate()
        datePicker.addTarget(self, action: "datePickerChanged", forControlEvents: UIControlEvents.ValueChanged)
        
        datePickerHintField.inputView = datePicker
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let item = itemToSave {
            descriptionField.text = item.simpleDescription
            itemContent.text = item.content
            scheduledDate = item.scheduledDate
            
            itemColorButton.tintColor = item.itemColor().colorValue()
            var title: String = "Item color: " + item.itemColor().description()
            itemColorButton.setTitle(title, forState: UIControlState.Normal)
        }
        updateButtonTitles()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func saveItemAction(sender: AnyObject) {
        var content: String = itemContent.text
        
        if itemToSave == nil {
            itemToSave = HTXToDoItem.createToDoItem(content)
        }
        
        var charactersCount = countElements(descriptionField.text)
        if charactersCount > 0{
            itemToSave!.simpleDescription = descriptionField.text
        } else {
            charactersCount = countElements(content)
            
            var index: Int = charactersCount > 10 ? 10 : charactersCount
            
            itemToSave!.simpleDescription = content.substringToIndex(advance(content.startIndex, index))
        }
        if let dateValue = scheduledDate{
            itemToSave!.scheduledDate = dateValue
        }
        
        HTXCoreDataManager.save()
        var alert = UIAlertController(title: nil, message: "Data saved", preferredStyle: UIAlertControllerStyle.Alert)
        let defaultAction = UIAlertAction(title: "OK", style: .Cancel, handler: nil)
        alert.addAction(defaultAction)
        let returnAction = UIAlertAction(title: "Return",
                                         style: .Default,
                                       handler: {
                                        (alert: UIAlertAction!) in self.back()
                                       })
        alert.addAction(returnAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func changeScheduledDate(sender: AnyObject){
        if datePickerHintField.isFirstResponder(){
            datePickerHintField.resignFirstResponder()
        } else {
            datePickerHintField.becomeFirstResponder()
        }
    }
    
    @IBAction func changeItemColor(sender: AnyObject){
        
    }
    
    func updateButtonTitles(){
        if let dateValue = scheduledDate{
            scheduledDateButton.setTitle(dateValue.formattedString(), forState: UIControlState.Normal)
        } else {
            scheduledDateButton.setTitle("Enter scheduled date", forState: UIControlState.Normal)
        }
    }
    
    func back(){
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func datePickerChanged(){
        scheduledDate = datePicker.date
        updateButtonTitles()
    }
}