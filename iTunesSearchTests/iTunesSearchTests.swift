//
//  iTunesSearchTests.swift
//  iTunesSearchTests
//
//  Created by Rhonny Gonzalez on 27/1/19.
//  Copyright © 2019 Rhonny Gonzalez. All rights reserved.
//

import XCTest
@testable import iTunesSearch

class iTunesSearchTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    let media = Media(JSON: ["trackId":1,"trackName":"Something","artworkUrl100":"","artistName":"Rhonny","longDescription":"This is a very good example","previewUrl":"","kind":"media"])
    
    func testMovieModel(){
    
        XCTAssertEqual("Something", media?.trackName)
        XCTAssertEqual("This is a very good example", media?.longDescription)
    }
    
    func testMusicModel(){
        
        XCTAssertEqual("Something", media?.trackName)
        XCTAssertEqual("This is a very good example", media?.longDescription)
    }
    
    func testTVShowModel(){
        
        XCTAssertEqual("Rhonny", media?.artistName)
        XCTAssertEqual("Something", media?.trackName)
        XCTAssertEqual("This is a very good example", media?.longDescription)
    }

}
