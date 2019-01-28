//
//  TVShow.swift
//  iTunesSearch
//
//  Created by Rhonny Gonzalez on 27/1/19.
//  Copyright © 2019 Rhonny Gonzalez. All rights reserved.
//

import Foundation
import ObjectMapper

class TVShow: Media{
    
    var artistName: String!
    var longDescription: String!
    
    //MARK - Mapping
    override func mapping(map: Map) {
        
        trackName <- map["trackName"]
        artworkUrl100 <- map["artworkUrl100"]
        artistName <- map["artistName"]
        longDescription <- map["longDescription"]
        
    }
    
}
