//
//  Episodes+CoreDataProperties.swift
//  TV
//
//  Created by Rajdeep Gill on 2016-04-03.
//  Copyright © 2016 Rajdeep Gill. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Episodes {

    @NSManaged var id: NSNumber?
    @NSManaged var url: String?
    @NSManaged var name: String?
    @NSManaged var season: NSNumber?
    @NSManaged var number: NSNumber?
    @NSManaged var airdate: String?
    @NSManaged var airtime: String?
    @NSManaged var airstamp: String?
    @NSManaged var runtime: String?
    @NSManaged var imageMedium: String?
    @NSManaged var imageOriginal: String?
    @NSManaged var summary: String?
    @NSManaged var watched: NSNumber?
    @NSManaged var shows: NSManagedObject?

}
