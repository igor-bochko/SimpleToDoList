//
//  ToDoItem.swift
//  SimpleToDoList
//
//  Created by HereTrix on 1/20/15.
//  Copyright (c) 2015 HereTrix. All rights reserved.
//

import Foundation
import CoreData

@objc(HTXToDoItem)
class HTXToDoItem: NSManagedObject {

    @NSManaged var content: String
    @NSManaged var date: NSDate
    @NSManaged var mark: NSNumber
    @NSManaged var color: AnyObject
    @NSManaged var scheduledDate: NSDate
    @NSManaged var simpleDescription: String

    class func createToDoItem(itemContent:String) -> HTXToDoItem{
        let managedContext: NSManagedObjectContext! = HTXCoreDataManager.sharedInstance.managedObjectContext!
        let entity =  NSEntityDescription.entityForName("ToDoItem", inManagedObjectContext:managedContext!)
        var item: HTXToDoItem = HTXToDoItem(entity: entity!, insertIntoManagedObjectContext: managedContext)
        item.content = itemContent
        item.date = NSDate()
        managedContext.save(nil)
        return item
    }
    
    class func fetchAllItems() -> Array<HTXToDoItem>{
        let managedContext = HTXCoreDataManager.sharedInstance.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName:"ToDoItem")
        let fetchedResults = managedContext?.executeFetchRequest(fetchRequest, error: nil) as [HTXToDoItem]?
        
        if let results: [HTXToDoItem] = fetchedResults{
            return results
        } else {
            return []
        }
    }
    
    func itemColor() -> ItemColor{
        return ItemColor(rawValue: color.integerValue)!
    }
}
