//
//  Media.swift
//  iTunesSearch
//
//  Created by Rhonny Gonzalez on 27/1/19.
//  Copyright © 2019 Rhonny Gonzalez. All rights reserved.
//

import Foundation
import ObjectMapper

enum MediaType: String{
    case Music = "music"
    case TVShow = "tvShow"
    case Movie = "movie"
}

class Media: Mappable{

    var trackId: Int!
    var trackName: String!
    var artworkUrl100: String!
    var artistName: String!
    var longDescription: String!
    var previewUrl: String!
    var kind: String!
    
    required init?(map: Map) {
        
    }
    
    //MARK - Mapping
    func mapping(map: Map) {
        
        trackId <- map["trackId"]
        trackName <- map["trackName"]
        artworkUrl100 <- map["artworkUrl100"]
        artistName <- map["artistName"]
        longDescription <- map["longDescription"]
        previewUrl <- map["previewUrl"]
        kind <- map["kind"]
        
    }
    
}

extension Media: Hashable{
    static func == (lhs: Media, rhs: Media) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    var hashValue: Int {
        return self.trackId ?? 0
    }
    
}

