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
        return URL(string: Constants.BASE_URL)!
    }
    // Endpoint URL
    var path: String {
        switch self {
        case .getNews:
            return Constants.GET_HEADLINES
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
            return .requestParameters(parameters: ["country": "\(country)" , "pageSize" : Constants.PAGE_SIZE , "page" : "\(offset)" , "apiKey": Constants.API_KEY] , encoding: URLEncoding.default)
        }
    }
}
