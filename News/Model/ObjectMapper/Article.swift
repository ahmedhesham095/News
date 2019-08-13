//
//  Article.swift
//  News
//
//  Created by Ahmed Hesham on 7/26/19.
//  Copyright © 2019 Ahmed Hesham. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class Article :  Mappable {

    var author : String?
    var content : String?
    var descriptionField : String?
    var publishedAt : String?
    var title : String?
    var url : String?
    var urlToImage : String?
    
    required init?(map: Map){}
    
    func mapping(map: Map)
    {
        author <- map["author"]
        content <- map["content"]
        descriptionField <- map["description"]
        publishedAt <- map["publishedAt"]
        title <- map["title"]
        url <- map["url"]
        urlToImage <- map["urlToImage"]
    }
}
