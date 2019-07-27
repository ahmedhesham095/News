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
    
    lazy var apiProvider: MoyaProvider<APIService> = {
        return MoyaProvider<APIService>(plugins: [NetworkLoggerPlugin(verbose: true)])
    }()
    // array of supported country codes in the NEWSAPI
    var countryCodes = ["ae", "ar" , "at",  "au" , "be" , "bg" , "br", "ca", "ch" , "cn" , "co" , "cu" , "cz", "de" , "eg" , "fr" , "gb" , "gr" , "hk", "hu" , "id" , "ie" , "il" ,  "in" ,  "it" ,  "jp", "kr" , "lt", "lv",  "ma",  "mx", "my", "ng" , "nl", "no", "nz" , "ph", "pl" , "pt", "ro" , "rs" , "ru", "sa", "se", "sg", "si", "sk" , "th" , "tr" , "tw" , "ua" , "us", "ve" , "za"]
    
    func loadNews(countryCode : String , pageOffset : Int)  {
        var artiles : [Article]
      let apiCountryCode = self.filterCountryCode(countryCode: countryCode)
        newsProtocol?.showLoader()
        apiProvider.request(.getNews(country: apiCountryCode, pageOffser: pageOffset), completion: { result in
                        switch result {
                        case let .success(response):
                            do {
                                print("response success")
                                let loadedData = try response.mapObject(NewsResonse.self)
                                artiles = loadedData.articles
                                newsDelegate.
                                completionHandler("success" , posts!)
                            }
                            catch {
                                // Server Error
                                print("Request is not succesfull From Server ")
                                completionHandler("other" , posts)
                            }
                        case let .failure(error):
                            // Network Error
                            print(error.errorDescription ?? "Unknown error description")
                            completionHandler("other" , posts)
                        }
                    })
    }
    func filterCountryCode(countryCode : String) -> String {
        // set default country code
        var defaultCountryCode = "us"
        
        countryCodes.forEach { (code) in
            if countryCode == code {
                defaultCountryCode = countryCode
            }
        }
        return defaultCountryCode
    }
    
    //    func loadPosts(completionHandler: @escaping (String , [Post]?) -> Void) {
    //        var posts : [Post]?
    //
    //        apiProvider.request(.getPostsData, completion: { result in
    //            switch result {
    //            case let .success(response):
    //                do {
    //                    print("response success")
    //                    let loadedData = try response.mapObject(PostResponse.self)
    //
    ////                    print(response.data)
    ////                    print(response.description)
    //                    posts = loadedData.posts!
    //                    completionHandler("success" , posts!)
    //                }
    //                catch {
    //                    // Server Error
    //                    print("Request is not succesfull From Server ")
    //                    completionHandler("other" , posts)
    //                }
    //            case let .failure(error):
    //                // Network Error
    //                print(error.errorDescription ?? "Unknown error description")
    //                completionHandler("other" , posts)
    //            }
    //        })
    //    }
    //
    //
    //    func loadComments(postId : String ,  completionHandler:  @escaping (String , [Comment]?) -> Void) {
    //        var commentsData : [Comment]?
    //
    //        apiProvider.request(.getCommentData(postId: postId), completion: { result in
    //            switch result {
    //            case let .success(response):
    //                do {
    //                    print("response success")
    //                    let loadedData = try response.mapObject(CommentResponse.self)
    //                    commentsData = loadedData.comments!
    //                    completionHandler("success" , commentsData)
    //                }
    //                catch {
    //                    // Server Error
    //                    print("Request is not succesfull From Server ")
    //                    completionHandler("other" , commentsData)
    //                }
    //            case let .failure(error):
    //                // Network Error
    //                print(error.errorDescription ?? "Unknown error description")
    //                completionHandler("other" , commentsData)
    //            }
    //        })
    //    }
    //
    
    
}
