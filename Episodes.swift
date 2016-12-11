//
//  Episodes.swift
//  TV
//
//  Created by Rajdeep Gill on 2016-04-03.
//  Copyright © 2016 Rajdeep Gill. All rights reserved.
//

import Foundation
import CoreData


class Episodes: NSManagedObject {
    
    // Insert code here to add functionality to your managed object subclassclass func addEmployee(context:NSManagedObjectContext, name:String, position:String, salary: Int, manager:Manager) -> Employee {
    
    class func addEpisode(context:NSManagedObjectContext, episode:Episodes, show:Shows) -> Episodes {
        
        let newEpisode = NSEntityDescription.insertNewObjectForEntityForName("Episodes", inManagedObjectContext: context) as! Episodes
        newEpisode.id = episode.id
        newEpisode.url = episode.url
        newEpisode.name = episode.name
        newEpisode.season = episode.season
        newEpisode.number = episode.number
        newEpisode.airdate = episode.airdate
        newEpisode.airtime = episode.airtime
        newEpisode.airstamp = episode.airstamp
        newEpisode.runtime = episode.runtime
        newEpisode.imageMedium = episode.imageMedium
        newEpisode.imageOriginal = episode.imageOriginal
        newEpisode.summary = episode.summary
        newEpisode.watched = episode.watched
        newEpisode.shows = episode.shows
        return newEpisode
    }
}
