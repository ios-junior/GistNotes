//
//  Note+CoreDataClass.swift
//  GistNotes
//
//  Created by ios-junior on 27.05.17.
//  Copyright © 2017 ios-junior. All rights reserved.
//

import Foundation
import CoreData

public class Note: NSManagedObject {

    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    class func fetchNote() -> [Note] {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        
        do {
            let fetchedNote = try context.fetch(request) as! [Note]
            return fetchedNote
        } catch let error as NSError {
            print("Error fetching Item objects: \(error.localizedDescription), \(error.userInfo)")
        }
        
        return [Note]()
        
    }
    class func fetchNoteByGist(gist_id: String) -> [Note] {
        
        var fetchedNote = [Note]()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        request.predicate = NSPredicate(format: "gist_id == %@", gist_id)
        
        do {
            fetchedNote = try context.fetch(request) as! [Note]
            
        } catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
        
        return fetchedNote
        
    }
    
    class func notesCount(gist_id: String) -> Int {
        
        var fetchedNote = [Note]()
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        request.predicate = NSPredicate(format: "gist_id == %@", gist_id)
        
        do {
            fetchedNote = try context.fetch(request) as! [Note]
            
        } catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
        
        return fetchedNote.count
        
    }

}
