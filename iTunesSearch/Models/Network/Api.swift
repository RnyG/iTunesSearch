//
//  Api.swift
//  iTunesSearch
//
//  Created by Rhonny Gonzalez on 27/1/19.
//  Copyright © 2019 Rhonny Gonzalez. All rights reserved.
//

import Foundation
import Moya

public enum Api {
    case media(term: String, media: String, offset: Int, limit: Int)
}

extension Api: TargetType {
    
    public var baseURL: URL {
        guard let url = URL(string: "https://itunes.apple.com/") else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    public var path: String {
        switch self {
        case .media:
            return "search"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .media:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .media(let term, let media, let offset, let limit):
            var parameters = [String: Any]()
            parameters["term"] = term
            parameters["media"] = media
            parameters["offset"] = offset
            parameters["limit"] = limit
            return parameters
        }
    }
    
    public var parameterEncoding: ParameterEncoding {
        switch self {
        case .media:
            return URLEncoding.queryString
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    
    public var task: Task {
        switch self {
        case .media(let term, let media, let offset, let limit):
            var parameters = [String: Any]()
            parameters["term"] = term
            parameters["media"] = media
            parameters["offset"] = offset
            parameters["limit"] = limit
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        default:
            return nil
        }
    }
    
}
