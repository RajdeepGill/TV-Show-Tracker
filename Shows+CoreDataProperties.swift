//
//  Shows+CoreDataProperties.swift
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

extension Shows {
    @NSManaged var countryCode: String?
    @NSManaged var countryName: String?
    @NSManaged var countryTimezone: String?
    @NSManaged var genres: [String]?
    @NSManaged var href: String?
    @NSManaged var id: String?
    @NSManaged var imageMedium: String?
    @NSManaged var imageOriginal: String?
    @NSManaged var imdb: String?
    @NSManaged var language: String?
    @NSManaged var lastUpdate: NSNumber?
    @NSManaged var name: String?
    @NSManaged var networkId: NSNumber?
    @NSManaged var networkName: String?
    @NSManaged var nextEpisode: String?
    @NSManaged var premiered: String?
    @NSManaged var previousEpisode: String?
    @NSManaged var ratingAvg: NSNumber?
    @NSManaged var ratingWeigt: NSNumber?
    @NSManaged var runtime: NSNumber?
    @NSManaged var scheduleDay: [String]?
    @NSManaged var scheduleTime: String?
    @NSManaged var status: String?
    @NSManaged var summary: String?
    @NSManaged var thetvdb: String?
    @NSManaged var tvrage: String?
    @NSManaged var type: String?
    @NSManaged var url: String?
    @NSManaged var webChannel: String?
    @NSManaged var episodes: NSSet?
}
