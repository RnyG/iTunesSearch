//
//  Music.swift
//  iTunesSearch
//
//  Created by Rhonny Gonzalez on 27/1/19.
//  Copyright © 2019 Rhonny Gonzalez. All rights reserved.
//

import Foundation
import ObjectMapper

class Music: Media{
    
    var artistName: String!
    
    override func mapping(map: Map) {
        
        trackName <- map["trackName"]
        artworkUrl100 <- map["artworkUrl100"]
        artistName <- map["artistName"]
        
    }
    
}
