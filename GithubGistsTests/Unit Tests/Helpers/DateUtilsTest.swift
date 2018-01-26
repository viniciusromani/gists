//
//  DateUtilsTest.swift
//  GithubGistsTests
//
//  Created by Vinicius Romani on 26/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import XCTest
import Nimble

/*
 * This class is going to test Date+Utils.
 */

class DateUtilsTest: XCTestCase {
    
    // MARK: Variables
    
    var isoDate: Date?
    private var isoDateString: String?
    
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
    
    /*
     * Testing a valid iso date parsing
     */
    func testSuccessfulISOParsing() {
        isoDateString = "2010-04-14T02:15:15Z"
        isoDate = Date(usingIsoFormatterFor: isoDateString)
        
        expect(self.isoDate).toNot(beNil())
        expect(self.isoDate?.stringUsingIsoFormatter).to(equal(self.isoDateString))
    }
    
    /*
     * Testing a invalid iso date parsing
     */
    func testInvalidISOParsing() {
        isoDateString = "2010-04-14"
        isoDate = Date(usingIsoFormatterFor: isoDateString)
        
        expect(self.isoDate).to(beNil())
        
        isoDateString = "01/05/1994"
        isoDate = Date(usingIsoFormatterFor: isoDateString)
        
        expect(self.isoDate).to(beNil())
    }
    
    /*
     * Method to validate a given date in string
     */
    func validate(dateString string: String?) {
        isoDate = Date(usingIsoFormatterFor: string)
        expect(self.isoDate).toNot(beNil())
        expect(self.isoDate?.stringUsingIsoFormatter).to(equal(string))
    }
}



