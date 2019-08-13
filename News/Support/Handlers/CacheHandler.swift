//
//  CacheHandler.swift
//  News
//
//  Created by Ahmed Hesham on 8/10/19.
//  Copyright © 2019 Ahmed Hesham. All rights reserved.
//

import Foundation
import RealmSwift
import Realm

class CacheHandler {
    
    lazy var realm:Realm = {
        return try! Realm()
    }()
    
    /**
     Save array of objects to database
     */
    func setArray(with array :[ArticleList])  {
        if getObjects(type: ArticleList.self).isEmpty == false {
            try! realm.write {
                realm.deleteAll()
            }
        }
        do {
            try realm.write({
                realm.add(array)
            })
        }
        catch {
            print("Error in Saving Object")
        }
    }
    
    /**
     Returs an array of Articles
     */
    func getObjects(type: ArticleList.Type) -> [ArticleList] {
        let objects = realm.objects(ArticleList.self).toArray(ofType: ArticleList.self) as [ArticleList]
        return objects
    }
    
}
