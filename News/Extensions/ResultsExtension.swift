//
//  ResultsExtension.swift
//  News
//
//  Created by Ahmed Hesham on 8/12/19.
//  Copyright © 2019 Ahmed Hesham. All rights reserved.
//

import Foundation
import RealmSwift

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for i in 0 ..< count {
            if let result = self[i] as? T {
                array.append(result)
            }
        }
        
        return array
    }
}
