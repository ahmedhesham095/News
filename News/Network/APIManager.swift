//
//  APIManager.swift
//  News
//
//  Created by Vodafone on 8/6/19.
//  Copyright © 2019 Ahmed Hesham. All rights reserved.
//

import Foundation
import Moya

class APIManager {
    
    static let apiSharredInistance = APIManager()
    
    typealias newsCompletion = ((Bool , NewsResonse?) -> Void)
    
    lazy var apiProvider: MoyaProvider<APIService> = {
        return MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin(verbose: true)])
    }()
    
    func loadNewsData(with countryCode : String , and pageOffset : Int ,completion: @escaping newsCompletion){
        apiProvider.request(.getNews(country: countryCode, pageOffser: pageOffset), completion: { result in
            switch result {
            case let .success(response):
                do {
                    print("response success")
                    let loadedData = try response.mapObject(NewsResonse.self)
                    completion(true , loadedData)
                }
                catch {
                    // Server Error
                    print("Request is not succesfull From Server ")
                    completion(false, nil)
                }
            case let .failure(error):
                // Network Error
                print(error.errorDescription ?? "Unknown error description")
                completion(false, nil)
            }
        })
    }
}
