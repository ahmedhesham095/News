//
//  NewsTest.swift
//  NewsTest
//
//  Created by Ahmed Hesham on 8/13/19.
//  Copyright © 2019 Ahmed Hesham. All rights reserved.
//

import XCTest

@testable import News
class NewsTest: XCTestCase {
    
    override func setUp() {
    }
    
    override func tearDown() {
    }
    
    func testLoadingPost() {
        let newsExpectation = expectation(description: "loadNews")
        
        APIManager.apiSharredInistance.loadNewsData(with: "us", and: 1) { (isSuccessful, response) in
            if isSuccessful {
                XCTAssertTrue(isSuccessful)
            } else {
                XCTFail("ERROR Fetching Data")
            }
            newsExpectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
}
