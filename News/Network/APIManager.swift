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
    
    private init(){}
    
    static let apiSharredInistance = APIManager()
    
    typealias newsCompletion = ((Bool , NewsResonse? , [ArticleList]?) -> Void)
    
    var cache = CacheHandler()
    
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
                    self.cache.setArray(with: ArticleList.convertToRealmModel(with: loadedData.articles ?? []))
                    completion(true , loadedData, nil)
                }
                catch {
                    // Server Error
                    let cachedData = self.loadFromCache()
                    print("Request is not succesfull From Server ")
                    completion(false, nil , cachedData)
                }
            case let .failure(error):
                // Network Error
                let cachedData = self.loadFromCache()
                print(error.errorDescription ?? "Unknown error description")
                completion(false, nil , cachedData)
            }
        })
    }
    
    func loadFromCache() -> [ArticleList]{
        var cachedArticles : [ArticleList]?
        let objects = self.cache.getObjects(type: ArticleList.self)
        if objects.count > 5 {
            cachedArticles = Array(objects.prefix(5))
        } else {
            cachedArticles = objects
        }
        return cachedArticles ?? []
    }
    
}
