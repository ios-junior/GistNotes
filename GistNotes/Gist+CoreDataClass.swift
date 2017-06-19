//
//  Gist+CoreDataClass.swift
//  GistNotes
//
//  Created by ios-junior on 27.05.17.
//  Copyright © 2017 ios-junior. All rights reserved.
//

import Foundation
import CoreData
import UIKit

public class Gist: NSManagedObject {

    
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    class func createGist(_ gistInfo: [String:AnyObject])
    {
        
        let id = gistInfo["id"] as! String
        let dateString = gistInfo["created_at"] as! String
        
        
        let request = Gist.gistFetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            let fetchedGist = try context.fetch(request as! NSFetchRequest<NSFetchRequestResult>) as! [Gist]
            // success ...
            if fetchedGist.count == 0 {
                
                let gist = NSEntityDescription.insertNewObject(forEntityName: "Gist", into: Gist.context) as! Gist
                gist.id = id
                gist.created_at = dateString
                gist.desc = gistInfo["description"] as? String
                gist.desc_original = gistInfo["description"] as? String
                if let ownerDict = gistInfo["owner"] as? [String: AnyObject] {
                    gist.login = ownerDict["login"] as? String
                    gist.avatarUrl = ownerDict["avatar_url"] as? String
                }
                
                do
                {
                    try gist.managedObjectContext!.save()
                    print("Core Data Saved")
                    
                }
                catch let error{
                    print("Core Data Error \(error)")
                }
                
            }
            
        } catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
        
    }
    
    class func fetchGist() -> [Gist] {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Gist")
//        request.predicate = NSPredicate(format: "id = %@", "dc04d91d3481175161c1183ee7a40baa")

        do {
            let fetchedGist = try context.fetch(request) as! [Gist]
            return fetchedGist
        } catch let error as NSError {
            print("Error fetching Item objects: \(error.localizedDescription), \(error.userInfo)")
        }
        
        return [Gist]()
        
    }
    
    class func fetchGistForNote() -> [Gist] {
        
        var arratGistId = [String]()
        
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            let fetchedNotes = try context.fetch(fr) as! [Note]
            
            for note in fetchedNotes {
                arratGistId.append(note.gist_id!)
            }
            
        } catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Gist")
        
        request.predicate = NSPredicate(format: "desc != desc_original or id IN %@", arratGistId)
        
        do {
            let fetchedGist = try context.fetch(request) as! [Gist]
            
            return fetchedGist
            
        } catch let error as NSError {
            // failure
            print("Fetch failed: \(error.localizedDescription)")
        }
        
        return [Gist]()
        
    }
    
    class func notesCount(gist_id: String) -> Int {

        let fr = NSFetchRequest<NSFetchRequestResult>(entityName:"Note")
        fr.predicate = NSPredicate(format: "gist_id == %@", gist_id)
        var rCount = 0
        let context = Note.context
        
        context.performAndWait() {
            do {
            rCount = try context.count(for: fr)
            }
            catch let error as NSError {
                print("Error: \(error.localizedDescription)")
                rCount = 0
            }
        }
        
        return rCount
        
    }
    
}
