//
//  Media.swift
//  iTunesSearch
//
//  Created by Rhonny Gonzalez on 27/1/19.
//  Copyright © 2019 Rhonny Gonzalez. All rights reserved.
//

import Foundation
import ObjectMapper

class Media: Mappable{

    var trackName: String!
    var artworkUrl100: String!
    
    required init?(map: Map) {
        
    }
    
    //MARK - Mapping
    func mapping(map: Map) {
        
        trackName <- map["trackName"]
        artworkUrl100 <- map["artworkUrl100"]
        
    }
    
}
