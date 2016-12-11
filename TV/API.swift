//
//  API.swift
//  TV
//
//  Created by Rajdeep Gill on 2016-03-30.
//  Copyright © 2016 Rajdeep Gill. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreData

class API{

    func queryShows(postEndpoint: String, completion: (shows: [Show]) -> Void) {
        var queryShows: [Show] = [Show]()
        
        Alamofire.request(.GET, postEndpoint).responseJSON { response in
            let json = JSON(response.result.value!)
            
            for i in (0 ..< json.count) {
                let show = Show()
                show.id =               json[i]["show"]["id"].stringValue
                show.url =              json[i]["show"]["url"].stringValue
                show.name =             json[i]["show"]["name"].stringValue
                show.type =             json[i]["show"]["type"].stringValue
                show.language =         json[i]["show"]["language"].stringValue
                show.genres =           json[i]["show"]["genres"].arrayValue.map { $0.string!}
                show.status =           json[i]["show"]["status"].stringValue
                show.runtime =          json[i]["show"]["runtime"].intValue
                show.premiered =        json[i]["show"]["premiered"].stringValue
                show.scheduleTime =     json[i]["show"]["schedule"]["time"].stringValue
                show.scheduleDay =      json[i]["show"]["schedule"]["days"].arrayValue.map { $0.string!}
                show.ratingAvg =        json[i]["show"]["rating"]["average"].floatValue
                show.ratingWeigt =      json[i]["show"]["rating"]["weight"].floatValue
                show.networkId =        json[i]["show"]["network"]["id"].intValue
                show.networkName =      json[i]["show"]["network"]["name"].stringValue
                show.countryName =      json[i]["show"]["network"]["country"]["name"].stringValue
                show.countryCode =      json[i]["show"]["network"]["country"]["code"].stringValue
                show.countryTimezone =  json[i]["show"]["network"]["country"]["timezone"].stringValue
                show.webChannel =       json[i]["show"]["webChannel"].stringValue
                show.tvrage =           json[i]["show"]["externals"]["tvrage"].stringValue
                show.thetvdb =          json[i]["show"]["externals"]["thetvdb"].stringValue
                show.imdb =             json[i]["show"]["externals"]["imdb"].stringValue
                show.imageMedium =      json[i]["show"]["image"]["medium"].stringValue
                show.imageOriginal =    json[i]["show"]["image"]["original"].stringValue
                show.summary =          json[i]["show"]["summary"].stringValue
                let string = show.summary
                show.summary = string!.stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil)
                show.lastUpdate =          json[i]["show"]["updated"].intValue
                show.href =             json[i]["show"]["_links"]["self"]["href"].stringValue
                show.previousEpisode =  json[i]["show"]["_links"]["previousepisode"]["href"].stringValue
                show.nextEpisode =      json[i]["show"]["_links"]["nextepisode"]["href"].stringValue
                
                queryShows.append(show)
            }
            completion(shows: queryShows)
        }
    }
    
    func allShows(postEndpoint: String, completion: (shows: [Show]) -> Void) {
        var allShows: [Show] = [Show]()
        
        Alamofire.request(.GET, postEndpoint).responseJSON { response in
            let json = JSON(response.result.value!)
            for i in (0 ..< json.count) {
                let show = Show()
                
                show.id =               json[i]["id"].stringValue
                show.url =              json[i]["url"].stringValue
                show.name =             json[i]["name"].stringValue
                show.type =             json[i]["type"].stringValue
                show.language =         json[i]["language"].stringValue
                show.genres =           json[i]["genres"].arrayValue.map { $0.string!}
                show.status =           json[i]["status"].stringValue
                show.runtime =          json[i]["runtime"].intValue
                show.premiered =        json[i]["premiered"].stringValue
                show.scheduleTime =     json[i]["schedule"]["time"].stringValue
                show.scheduleDay =      json[i]["schedule"]["days"].arrayValue.map { $0.string!}
                show.ratingAvg =        json[i]["rating"]["average"].floatValue
                show.ratingWeigt =      json[i]["rating"]["weight"].floatValue
                show.networkId =        json[i]["network"]["id"].intValue
                show.networkName =      json[i]["network"]["name"].stringValue
                show.countryName =      json[i]["network"]["country"]["name"].stringValue
                show.countryCode =      json[i]["network"]["country"]["code"].stringValue
                show.countryTimezone =  json[i]["network"]["country"]["timezone"].stringValue
                show.webChannel =       json[i]["webChannel"].stringValue
                show.tvrage =           json[i]["externals"]["tvrage"].stringValue
                show.thetvdb =          json[i]["externals"]["thetvdb"].stringValue
                show.imdb =             json[i]["externals"]["imdb"].stringValue
                show.imageMedium =      json[i]["image"]["medium"].stringValue
                show.imageOriginal =    json[i]["image"]["original"].stringValue
                show.summary =          json[i]["summary"].stringValue
                let string = show.summary
                show.summary = string!.stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil)
                show.lastUpdate =          json[i]["updated"].intValue
                show.href =             json[i]["_links"]["self"]["href"].stringValue
                show.previousEpisode =  json[i]["_links"]["previousepisode"]["href"].stringValue
                show.nextEpisode =      json[i]["_links"]["nextepisode"]["href"].stringValue
                allShows.append(show)
            }
            completion(shows: allShows)
        }
    }
    
    func getShow(postEndpoint: String, completion: (show: Show) -> Void) {
        let getShow = Show()


        Alamofire.request(.GET, postEndpoint).responseJSON { response in
            let json = JSON(response.result.value!)
            for i in (0 ..< json.count) {
                
                getShow.id =               json[i]["id"].stringValue
                getShow.url =              json[i]["url"].stringValue
                getShow.name =             json[i]["name"].stringValue
                getShow.type =             json[i]["type"].stringValue
                getShow.language =         json[i]["language"].stringValue
                getShow.genres =           json[i]["genres"].arrayValue.map { $0.string!}
                getShow.status =           json[i]["status"].stringValue
                getShow.runtime =          json[i]["runtime"].intValue
                getShow.premiered =        json[i]["premiered"].stringValue
                getShow.scheduleTime =     json[i]["schedule"]["time"].stringValue
                getShow.scheduleDay =      json[i]["schedule"]["days"].arrayValue.map { $0.string!}
                getShow.ratingAvg =        json[i]["rating"]["average"].floatValue
                getShow.ratingWeigt =      json[i]["rating"]["weight"].floatValue
                getShow.networkId =        json[i]["network"]["id"].intValue
                getShow.networkName =      json[i]["network"]["name"].stringValue
                getShow.countryName =      json[i]["network"]["country"]["name"].stringValue
                getShow.countryCode =      json[i]["network"]["country"]["code"].stringValue
                getShow.countryTimezone =  json[i]["network"]["country"]["timezone"].stringValue
                getShow.webChannel =       json[i]["webChannel"].stringValue
                getShow.tvrage =           json[i]["externals"]["tvrage"].stringValue
                getShow.thetvdb =          json[i]["externals"]["thetvdb"].stringValue
                getShow.imdb =             json[i]["externals"]["imdb"].stringValue
                getShow.imageMedium =      json[i]["image"]["medium"].stringValue
                getShow.imageOriginal =    json[i]["image"]["original"].stringValue
                getShow.summary =          json[i]["summary"].stringValue
                let string = getShow.summary
                getShow.summary = string!.stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil)
                getShow.lastUpdate =       json[i]["updated"].intValue
                getShow.href =             json[i]["_links"]["self"]["href"].stringValue
                getShow.previousEpisode =  json[i]["_links"]["previousepisode"]["href"].stringValue
                getShow.nextEpisode =      json[i]["_links"]["nextepisode"]["href"].stringValue
                print(getShow.name)
            }
            completion(show: getShow)
        }
    }
    
    func getEpisodes(postEndpoint: String, completion: (episodes: [Episode]) -> Void) {
        var getEpisodes: [Episode] = [Episode]()
        
        Alamofire.request(.GET, postEndpoint).responseJSON { response in
            let json = JSON(response.result.value!)
            for i in (0 ..< json.count) {
                let episode = Episode()
                episode.id =               json[i]["id"].intValue
                episode.url =              json[i]["url"].stringValue
                episode.name =             json[i]["name"].stringValue
                episode.season =           json[i]["season"].intValue
                episode.number =           json[i]["number"].intValue
                episode.airdate =          json[i]["airdate"].stringValue
                episode.airtime =          json[i]["airtime"].stringValue
                episode.airstamp =         json[i]["airstamp"].stringValue
                episode.runtime =          json[i]["runtime"].stringValue
                episode.imageMedium =      json[i]["image"]["medium"].stringValue
                episode.imageOriginal =    json[i]["image"]["original"].stringValue
                episode.summary =          json[i]["summary"].stringValue
                getEpisodes.append(episode)
            }
            completion(episodes: getEpisodes)
        }
    }

}