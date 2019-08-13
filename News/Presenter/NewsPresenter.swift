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
        { (isSuccessful, news ,cachedNews ) in
            self.newsDelegate?.hideLoader()
            if isSuccessful {
                if news?.articles?.isEmpty == true , countryCode != Constants.DEFAULT_COUNTRY_CODE {
                    self.loadNews(countryCode: Constants.DEFAULT_COUNTRY_CODE , pageOffset: 1)
                }else {
                    artiles = news?.articles ?? []
                    self.newsDelegate?.configureUI(with: artiles ?? [], and: "success")
                }
            } else {
                self.newsDelegate?.configureofflineUI(with: cachedNews ?? [])
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
    
}
