//
//  Network.swift
//  iTunesSearch
//
//  Created by Rhonny Gonzalez on 28/1/19.
//  Copyright © 2019 Rhonny Gonzalez. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper

class Network{

    static let provider = MoyaProvider<Api>(plugins: [NetworkLoggerPlugin(verbose: false)])
    
    static func request(target: Api, success successCallback: @escaping (Response) -> Void, error errorCallback: @escaping (Swift.Error) -> Void, failure failureCallback: @escaping (MoyaError) -> Void) {
        provider.request(target) { (result) in
            switch result {
            case .success(let response):
                
                if response.statusCode >= 200 && response.statusCode <= 300 {
                    successCallback(response)
                }
                else {
                    let error = NSError(domain:"com.RnyG.iTunesSearch", code:0, userInfo:[NSLocalizedDescriptionKey: "Parsing Error"])
                    errorCallback(error)
                    
                }
            case .failure(let error):
                failureCallback(error)
            }
        }
    }
    
    static func getMedia(term: String, media: String, offset: Int, limit: Int, success successCallback: @escaping (_ media: Array<Media>, _ total: Int) -> Void, error errorCallback: @escaping (Swift.Error) -> Void, failure failureCallback: @escaping (MoyaError) -> Void) {
        
        self.request(target: .media(term: term, media: media, offset: offset, limit: limit), success: { (response) in
            do {
                let responseJSON:AnyObject = try response.mapJSON() as AnyObject
                let total = responseJSON["resultCount"] as? Int ?? 0
                let media = Mapper<Media>().mapArray(JSONObject: responseJSON["results"])
                successCallback(media!, total)
            } catch {
                errorCallback(error)
            }
        }, error: { (error) in
            errorCallback(error)
        }, failure: { (error) in
            failureCallback(error)
        })
    }
    
    
}
