//
//  Show.swift
//  tvgeek2
//
//  Created by Ryan Webber on 2015-02-15.
//  Copyright (c) 2015 Ryan Webber. All rights reserved.
//

import Foundation
import CloudKit

class Show {
    var id: String?
    var url: String?
    var name: String?
    var type: String?
    var language: String?
    var genres: [String]?
    var status: String?
    var runtime: Int?
    var premiered: String?
    var scheduleTime: String?
    var scheduleDay: [String]?
    var ratingAvg: Float?
    var ratingWeigt: Float?
    var networkId: Int?
    var networkName: String?
    var countryName: String?
    var countryCode: String?
    var countryTimezone: String?
    var webChannel: String?
    var tvrage: String?
    var thetvdb: String?
    var imdb: String?
    var imageMedium: String?
    var imageOriginal: String?
    var summary: String?
    var lastUpdate: Int?
    var href: String?
    var previousEpisode: String?
    var nextEpisode: String?
    var bookmark = false
    
//    func formatTime()->String?{
//        if let at = self.airTime{
//            let range = at.rangeOfString(":")
//            if let r = range{
//                let t24:Int? =  Int(at.substringToIndex(r.startIndex))
//                if let t24a = t24{
//                    if(t24a == 12){
//                        return "Noon"
//                    }else if(t24a == 24 || t24a == 0){
//                        return "Midnight"
//                    }else if(t24a > 12){
//                        return "\(t24a-12):00pm"
//                    }else{
//                        return "\(t24a):00am"
//                    }
//                }else{
//                    return nil
//                }
//            }else{
//                return nil
//            }
//        }else{
//            return nil
//        }
//    }
}

