//
//  Gist+CoreDataProperties.swift
//  GistNotes
//
//  Created by ios-junior on 27.05.17.
//  Copyright © 2017 ios-junior. All rights reserved.
//

import Foundation
import CoreData


extension Gist {

    @nonobjc public class func gistFetchRequest() -> NSFetchRequest<Gist> {
        return NSFetchRequest<Gist>(entityName: "Gist")
    }

    @NSManaged public var id: String?
    @NSManaged public var avatarUrl: String?
    @NSManaged public var desc: String?
    @NSManaged public var desc_original: String?
    @NSManaged public var login: String?
    @NSManaged public var notes: [Note]?
    @NSManaged public var created_at: String?
    

}
