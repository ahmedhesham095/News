//
//  ArticleList.swift
//  News
//
//  Created by Ahmed Hesham on 8/12/19.
//  Copyright © 2019 Ahmed Hesham. All rights reserved.
//

import Foundation
import RealmSwift

class ArticleList: Object {
    
    @objc  dynamic var title: String = ""
    @objc dynamic var descriptionField: String = ""
    @objc  dynamic var url : String = ""
    @objc  dynamic var urlToImage: String = ""
    @objc  dynamic var publishedAt: String = ""
    @objc dynamic var content: String = ""
    @objc  dynamic var author : String = ""
    
    convenience init(title: String, descriptionField: String, url: String ,urlToImage: String , publishedAt: String , content : String , author : String ){
        self.init()
        
        self.title = title
        self.descriptionField = descriptionField
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
        self.author = author
    }
}
