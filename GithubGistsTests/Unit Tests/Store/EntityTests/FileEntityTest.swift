//
//  FileEntityTest.swift
//  GithubGistsTests
//
//  Created by Vinicius Romani on 18/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import XCTest
import Nimble

/*
 * This class is going to test FileEntity and
 * its respective mapper described in FileEntity+Mappable.
 */

class FileEntityTest: XCTestCase {
    
    // MARK: - Variables
    
    private var _localJSON: String = ""
    private var jsonDecoder = JSONDecoder()
    
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
     *  It should parse because it has a filename and size.
     *  This is also testing a json with no attributes being sent.
     */
    func testOnlyInvalidSizeAttributeValidJSON() {
        localJSON = "withfilename_withoutatt"
        
        expect { try self.jsonDecoder.decode(FileEntity.self, from: self.jsonData) }.toNot(throwError())
        
        let fileEntity = try? jsonDecoder.decode(FileEntity.self, from: jsonData)
        expect(fileEntity).toNot(beNil())
        expect(fileEntity?.name).toNot(beNil())
        expect(fileEntity?.size).toNot(beNil())
        expect(fileEntity?.language).to(beNil())
        expect(fileEntity?.url).to(beNil())
    }
    
    /*
     *  It should not parse because it does not have a filename.
     */
    func testNoFilenameAttribute() {
        localJSON = "withoutfilename_withatt"
        
        expect { try self.jsonDecoder.decode(FileEntity.self, from: self.jsonData) }.to(throwError())
        
        let fileEntity = try? jsonDecoder.decode(FileEntity.self, from: jsonData)
        expect(fileEntity).to(beNil())
    }
    
    /*
     *  It should parse because filename and size are being sent.
     *  All other parameters exist in json but their values are null.
     */
    func testInvalidFilenameValueJSON() {
        localJSON = "withwrongfilename_withatt"
        
        expect { try self.jsonDecoder.decode(FileEntity.self, from: self.jsonData) }.toNot(throwError())
        
        let fileEntity = try? jsonDecoder.decode(FileEntity.self, from: jsonData)
        expect(fileEntity).toNot(beNil())
        expect(fileEntity?.name).toNot(beNil())
        expect(fileEntity?.size).toNot(beNil())
        expect(fileEntity?.language).to(beNil())
        expect(fileEntity?.url).to(beNil())
    }
}

// MARK: - Testable Entity Protocol

extension FileEntityTest: TestableEntity {
    
    // MARK: - Protocol variable
    
    var localJSON: String {
        get { return _localJSON }
        set { _localJSON = newValue }
    }
    
    // MARK: - Protocol method
    
    func testSuccessFulInit() {
        localJSON = "file_entity"
        
        expect { try self.jsonDecoder.decode(FileEntity.self, from: self.jsonData) }.toNot(throwError())
        
        let fileEntity = try? jsonDecoder.decode(FileEntity.self, from: jsonData)
        expect(fileEntity).toNot(beNil())
        expect(fileEntity?.name).toNot(beNil())
        expect(fileEntity?.size).toNot(beNil())
        expect(fileEntity?.language).toNot(beNil())
        expect(fileEntity?.url).toNot(beNil())
    }
}
