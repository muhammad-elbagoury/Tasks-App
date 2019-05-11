//
//  CoreDataHandler.swift
//  My Tasks App tr
//
//  Created by Muhammad Elbagoury on 1/20/19.
//  Copyright © 2019 Developers2Be. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataHandler {
    
    class func getCoreDataObject() -> NSManagedObjectContext {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    
    class func saveIntoCoreData(taskItem: Tasks) {
        
        let context = getCoreDataObject()
        
        do {
            try context.save()
        } catch (let error) {
            print(error.localizedDescription)
        }
    }
    
    
    class func getDataFromCoreData() -> [Tasks]? {
        
        let context = getCoreDataObject()
        var tasks: [Tasks]?
        
        do {
            tasks = try context.fetch(Tasks.fetchRequest())
        } catch (let error) {
            print(error.localizedDescription)
        }
        return tasks
    }
    
    
    class func deleteObjectFromCoreData(task: Tasks) -> [Tasks]? {
        
        let context = CoreDataHandler.getCoreDataObject()
        context.delete(task)
        do {
            try context.save()
        } catch (let error) {
            print(error.localizedDescription)
        }
        return CoreDataHandler.getDataFromCoreData()
    }
    
    
    class func getSpecificItemFromCoreData(itemName: String) -> [Tasks]? {
        
        var tasks: [Tasks]?
        let context = CoreDataHandler.getCoreDataObject()
        //let entity = NSEntityDescription.entity(forEntityName: "Tasks", in: context)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Tasks.entity().name ?? "")
        
        
        /* To be insensitive to uppercase & lowercase >> Use contains[c] or [cd]
            To be sensitive >> Use contains
         */
        
        request.predicate = NSPredicate(format: "taskName contains[c] %@", itemName)
        
        do {
            tasks = try context.fetch(request) as? [Tasks]
        } catch (let error) {
            print(error.localizedDescription)
        }
        return tasks
    }
     
    
}
