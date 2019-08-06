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


class NewsPresenter: NSObject {
    
    var newsDelegate : NewsProtocol?
    
    init(withDelegate newsDelegate: NewsProtocol) {
        self.newsDelegate = newsDelegate
    }
    
    func loadNews(countryCode : String = Locale.current.regionCode ?? "" , pageOffset : Int){
        var artiles : [Article]?
        newsDelegate?.showLoader()
        APIManager.apiSharredInistance.loadNewsData(with: countryCode, and: pageOffset) { (isSuccessful, news) in
            self.newsDelegate?.hideLoader()
            if isSuccessful {
                if news?.articles?.isEmpty == false {
                    self.loadNews(countryCode: "us", pageOffset: 1)
                }else {
                    artiles = news?.articles ?? []
                    self.newsDelegate?.configureUI(with: artiles ?? [], and: "success")
                }
            } else {
                self.newsDelegate?.configureUI(with: artiles ?? [], and: "error")
            }
        }
    }
}
