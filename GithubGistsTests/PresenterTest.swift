//
//  PresenterTest.swift
//  GithubGistsTests
//
//  Created by Vinicius Romani on 03/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import XCTest
import SwiftyJSON

class PresenterTest: XCTestCase {
    
    var mainScreenPresenter: ListPublicGistPresenter!
    var detailScreenPresenter: GistDetailPresenter!
    var gistWorker: GistWorker!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        mainScreenPresenter = ListPublicGistPresenter()
        detailScreenPresenter = GistDetailPresenter()
        gistWorker = GistWorker(store: GistRestStore())
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMainScreenPresenter() {
        gistWorker.fetchPublicGists(successHandler: { (gists) in
            let result = self.mainScreenPresenter.getDisplayedGistCells(from: gists)
            XCTAssert(result.count == 1)
        }) { (error) in
            XCTAssert(true)
        }
    }
    
    func testDetailScreenPresenter() {
        gistWorker.fetchGist(with: "72195ef6fcaf7ae444592e47d0e35e0c", successHandler: { (gist) in
            let result = self.detailScreenPresenter.getDisplayedCells(from: gist)
            XCTAssert(result.count == 6)
            for displayedInfoCellContent in result {
                XCTAssert(displayedInfoCellContent.content != nil)
            }
        }) { (error) in
            XCTAssert(true)
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
