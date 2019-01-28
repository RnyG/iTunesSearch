//
//  Movie.swift
//  iTunesSearch
//
//  Created by Rhonny Gonzalez on 27/1/19.
//  Copyright © 2019 Rhonny Gonzalez. All rights reserved.
//

import Foundation
import ObjectMapper

class Movie: Media{
    
    var longDescription: String!
    
    //MARK - Mapping
    override func mapping(map: Map) {
        
        trackName <- map["trackName"]
        artworkUrl100 <- map["artworkUrl100"]
        longDescription <- map["longDescription"]
        
    }
    
}
