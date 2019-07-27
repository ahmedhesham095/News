//
//  Article.swift
//  News
//
//  Created by Ahmed Hesham on 7/26/19.
//  Copyright © 2019 Ahmed Hesham. All rights reserved.
//

import Foundation
import ObjectMapper


class Article : NSObject, NSCoding, Mappable , Codable{
    
    var author : String?
    var content : String?
    var descriptionField : String?
    var publishedAt : String?
    var title : String?
    var url : String?
    var urlToImage : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return Article()
    }
    required init?(map: Map){}
    private override init(){}
    
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
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        author = aDecoder.decodeObject(forKey: "author") as? String
        content = aDecoder.decodeObject(forKey: "content") as? String
        descriptionField = aDecoder.decodeObject(forKey: "description") as? String
        publishedAt = aDecoder.decodeObject(forKey: "publishedAt") as? String
        title = aDecoder.decodeObject(forKey: "title") as? String
        url = aDecoder.decodeObject(forKey: "url") as? String
        urlToImage = aDecoder.decodeObject(forKey: "urlToImage") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if author != nil{
            aCoder.encode(author, forKey: "author")
        }
        if content != nil{
            aCoder.encode(content, forKey: "content")
        }
        if descriptionField != nil{
            aCoder.encode(descriptionField, forKey: "description")
        }
        if publishedAt != nil{
            aCoder.encode(publishedAt, forKey: "publishedAt")
        }
        if title != nil{
            aCoder.encode(title, forKey: "title")
        }
        if url != nil{
            aCoder.encode(url, forKey: "url")
        }
        if urlToImage != nil{
            aCoder.encode(urlToImage, forKey: "urlToImage")
        }
        
    }
    
}
