//
//  GistRestDataSourceTest.swift
//  GithubGistsTests
//
//  Created by Vinicius Romani on 09/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import XCTest
import Moya

class GistRestDataSourceTest: XCTestCase {
    
    // MARK: Variables
    
    private var dataSource = GistRestDataSource()
    private let baseURL = URL(string: "https://api.github.com/gists/")!
    private let gistID = "4c4c1ad795837fae91d5c2be598ecad8"
    
    // MARK: - XCTestCase Cycle
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func testPublicGistsEndpoint() {
        let providerEndpoint = dataSource.provider.endpoint(.publicGists)
        
        let expectedEndpoint = "\(baseURL)public"
        
        XCTAssert(providerEndpoint.url == expectedEndpoint)
        XCTAssert(providerEndpoint.method == Moya.Method.get)
    }
    
    func testSpecificGistsEndpoint() {
        let providerEndpoint = dataSource.provider.endpoint(.specificGist(gistId: gistID))
        
        let expectedEndpoint = "\(baseURL)\(gistID)"
        
        XCTAssert(providerEndpoint.url == expectedEndpoint)
        XCTAssert(providerEndpoint.method == Moya.Method.get)
    }
}
