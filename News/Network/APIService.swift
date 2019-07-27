//
//  APIService.swift
//  News
//
//  Created by Ahmed Hesham on 7/26/19.
//  Copyright © 2019 Ahmed Hesham. All rights reserved.
//

import Foundation
import Moya

enum APIService {
    case getNews(country : String , pageOffser : Int)
}

extension APIService :TargetType{
    //Request Headers
    var headers: [String : String]? {
        return ["Content-Type" : "application/json"]
    }
    //Base URL
    var baseURL: URL {
        return URL(string: "https://newsapi.org/v2")!
    }
    // Endpoint URL
    var path: String {
        switch self {
        case .getNews:
            return "/top-headlines"
        }
    }
    // Request type
    var method: Moya.Method {
        switch self {
        case .getNews:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        
        switch self {
        //Request Parameters
        case .getNews(let country , let offset ):
            return .requestParameters(parameters: ["country": "\(country)" , "pageSize" : "10" , "page" : "\(offset)" , "apiKey": "cb185160fb7648adb8eea2395b129294"] , encoding: URLEncoding.default)
        }
    }
}
