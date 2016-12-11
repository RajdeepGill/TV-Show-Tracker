//
//  Episode.swift
//  TVGeek
//
//  Created by Ryan Webber on 2015-04-02.
//  Copyright (c) 2015 Ryan Webber. All rights reserved.
//

import Foundation
import CloudKit

class Episode {
    var id: Int?
    var url: String?
    var name: String?
    var season: Int?
    var number: Int?
    var airdate: String?
    var airtime: String?
    var airstamp: String?
    var runtime: String?
    var imageMedium: String?
    var imageOriginal: String?
    var summary: String?
    var watched: Int?


    
//    func format()->String{
//        if episode < 10{
//            return "e0\(episode)"
//        }else{
//            return "e\(episode)"
//        }
//    }
}