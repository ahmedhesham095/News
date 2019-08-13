//
//  HomePresenter.swift
//  News
//
//  Created by Ahmed Hesham on 7/26/19.
//  Copyright © 2019 Ahmed Hesham. All rights reserved.
//

import UIKit
import Moya_ObjectMapper
import Moya
import ObjectMapper
import RealmSwift

class NewsPresenter: NSObject {
    
    var newsDelegate : NewsProtocol?
    
    init(withDelegate newsDelegate: NewsProtocol) {
        self.newsDelegate = newsDelegate
    }
    var cache = CacheHandler()
    /**
     calls the network manager for loading news
     parameter countryCode: Describe the country code
     parameter pageOffset: Describe the offset in the API
     */
    func loadNews(countryCode : String?  , pageOffset : Int){
        var artiles : [Article]?
        let requestCountryCode = validateCountryCode(usingCode : countryCode ?? "")
        newsDelegate?.showLoader()
        APIManager.apiSharredInistance.loadNewsData(with: requestCountryCode , and: pageOffset)
        { (isSuccessful, news) in
            self.newsDelegate?.hideLoader()
            if isSuccessful {
                if news?.articles?.isEmpty == true , countryCode != "us" {
                    self.loadNews(countryCode: "us", pageOffset: 1)
                }else {
                    artiles = news?.articles ?? []
                    self.cache.setArray(with: self.convertToRealmModel(with: news?.articles ?? []))
                    self.newsDelegate?.configureUI(with: artiles ?? [], and: "success")
                }
            } else {
                self.loadFromCache()
            }
        }
    }
    /**
     validate if the country code is empty return the locale of the device
     parameter countryCode: Describe the country code
     */
    func validateCountryCode(usingCode countryCode: String) -> String {
        var code : String?
        if countryCode.isEmpty == true {
            code = Locale.current.regionCode
        } else {
            code = countryCode
        }
        return code ?? ""
    }
    
    func convertToRealmModel(with articles : [Article]) -> [ArticleList] {
        var articlesList = [ArticleList]()
        articles.forEach { (article) in
            let articleData = ArticleList()
            articleData.title = article.title ?? ""
            articleData.author = article.author ?? ""
            articleData.publishedAt = article.publishedAt ?? ""
            articleData.content = article.content ?? ""
            articleData.descriptionField = article.descriptionField ?? ""
            articleData.url = article.url ?? ""
            articleData.urlToImage = article.urlToImage ?? ""
            articlesList.append(articleData)
        }
        return articlesList
    }
    
    func loadFromCache() {
        var cachedArticles : [ArticleList]?
        DispatchQueue.main.async {
            let objects = self.cache.getObjects(type: ArticleList.self)
            if objects.count > 5 {
                cachedArticles = Array(objects.prefix(5))
                self.newsDelegate?.configureofflineUI(with: cachedArticles ?? [])
            } else {
                cachedArticles = objects
                self.newsDelegate?.configureofflineUI(with: cachedArticles ?? [])
            }
        }
    }
    
}
