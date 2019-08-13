//
//  NewsResonse.swift
//  News
//
//  Created by Ahmed Hesham on 7/26/19.
//  Copyright © 2019 Ahmed Hesham. All rights reserved.
//

import Foundation
import ObjectMapper


class NewsResonse : Mappable{
    
    var articles : [Article]?
    var status : String?
    var totalResults : Int?
    
    required init?(map: Map){}
   
    func mapping(map: Map)
    {
        articles <- map["articles"]
        status <- map["status"]
        totalResults <- map["totalResults"]
    }
}
