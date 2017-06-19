//
//  Note+CoreDataProperties.swift
//  GistNotes
//
//  Created by ios-junior on 27.05.17.
//  Copyright © 2017 ios-junior. All rights reserved.
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var desc: String?
    @NSManaged public var gist_id: String?
    @NSManaged public var gist: Gist?

}
