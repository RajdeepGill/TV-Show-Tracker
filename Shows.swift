//
//  Shows.swift
//  TV
//
//  Created by Rajdeep Gill on 2016-04-02.
//  Copyright © 2016 Rajdeep Gill. All rights reserved.
//

import Foundation
import CoreData


class Shows: NSManagedObject {
    
    // Insert code here to add functionality to your managed object subclass
    class func addShow(context:NSManagedObjectContext, show:Show) -> Shows {
        
        let newShow = NSEntityDescription.insertNewObjectForEntityForName("Shows", inManagedObjectContext: context) as! Shows
        
        newShow.id = show.id
        newShow.url = show.url
        newShow.name = show.name
        newShow.type = show.type
        newShow.language = show.language
        newShow.genres = show.genres
        newShow.status = show.status
        newShow.runtime = show.runtime
        newShow.premiered = show.premiered
        newShow.scheduleTime = show.scheduleTime
        newShow.scheduleDay = show.scheduleDay
        newShow.ratingAvg = show.ratingAvg
        newShow.ratingWeigt = show.ratingWeigt
        newShow.networkId = show.networkId
        newShow.networkName = show.networkName
        newShow.countryName = show.countryName
        newShow.countryCode = show.countryCode
        newShow.countryTimezone = show.countryTimezone
        newShow.webChannel = show.webChannel
        newShow.tvrage = show.tvrage
        newShow.thetvdb = show.thetvdb
        newShow.imdb = show.imdb
        newShow.imageMedium = show.imageMedium
        newShow.imageOriginal = show.imageOriginal
        newShow.summary = show.summary
        newShow.lastUpdate = show.lastUpdate
        newShow.href = show.href
        newShow.previousEpisode = show.previousEpisode
        newShow.nextEpisode = show.nextEpisode
        return newShow
    }
}
