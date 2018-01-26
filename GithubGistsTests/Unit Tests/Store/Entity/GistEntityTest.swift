//
//  GistEntityTest.swift
//  GithubGistsTests
//
//  Created by Vinicius Romani on 18/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import XCTest
import Nimble

/*
 * This class is going to test GistEntity and
 * its respective mapper described in GistEntity+Mappable.
 */

class GistEntityTest: XCTestCase {
    
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
     *  It should not parse and throw an error.
     */
    func testNoIdAttribute() {
        localJSON = "withoutid_withatt"
        
        expect { try self.jsonDecoder.decode(GistEntity.self, from: self.jsonData) }.to(throwError())
        
        let gistEntity = try? jsonDecoder.decode(GistEntity.self, from: jsonData)
        expect(gistEntity).to(beNil())
    }
    
    /*
     *  Parameters we want to cover in this test:
     *  - description should be null (because the value is null)
     *  - apiURL should be null (because the value is null)
     *  - htmlURL should be null (because the value is null)
     *  - files should not have objects in it
     *  - owner should exist
     */
    func testZeroFilesOneOwnerJSON() {
        localJSON = "withid_withoutfile_withowner"
        
        expect { try self.jsonDecoder.decode(GistEntity.self, from: self.jsonData) }.toNot(throwError())
        
        let gistEntity = try? jsonDecoder.decode(GistEntity.self, from: jsonData)
        expect(gistEntity).toNot(beNil())
        expect(gistEntity?.id).toNot(beNil())
        expect(gistEntity?.description).to(beNil())
        expect(gistEntity?.apiURL).to(beNil())
        expect(gistEntity?.htmlURL).to(beNil())
        expect(gistEntity?.files).toNot(beNil())
        expect(gistEntity?.files.count).to(equal(0))
        expect(gistEntity?.owner).toNot(beNil())
    }
    
    /*
     *  Parameters we want to cover in this test:
     *  - description should be null (because it is not being sent)
     *  - apiURL should be null (because it is not being sent)
     *  - htmlURL should be null (because it is not being sent)
     *  - files should have only one object
     *  - owner should be null
     *  - isPublic should be true
     *  - createAt should be nil
     */
    func testOneFileZeroOnwersJSON() {
        localJSON = "withid_withfile_withoutowner"
        
        expect { try self.jsonDecoder.decode(GistEntity.self, from: self.jsonData) }.toNot(throwError())
        
        let gistEntity = try? jsonDecoder.decode(GistEntity.self, from: jsonData)
        expect(gistEntity).toNot(beNil())
        expect(gistEntity?.id).toNot(beNil())
        expect(gistEntity?.description).to(beNil())
        expect(gistEntity?.apiURL).to(beNil())
        expect(gistEntity?.htmlURL).to(beNil())
        expect(gistEntity?.files).toNot(beNil())
        expect(gistEntity?.files.count).to(equal(1))
        expect(gistEntity?.owner).to(beNil())
        expect(gistEntity?.isPublic).to(equal(1))
        expect(gistEntity?.createdAt).to(beNil())
    }
    
    /*
     *  Parameters we want to cover in this test:
     *  - files should have two objects
     *  - owner should exist
     *  - isPublic should be false
     *  - createdAt should exist
     */
    func testTwoFilesZeroOnwersJSON() {
        localJSON = "withid_withfiles_withowner"
        
        expect { try self.jsonDecoder.decode(GistEntity.self, from: self.jsonData) }.toNot(throwError())
        
        let gistEntity = try? jsonDecoder.decode(GistEntity.self, from: jsonData)
        expect(gistEntity).toNot(beNil())
        expect(gistEntity?.id).toNot(beNil())
        expect(gistEntity?.files).toNot(beNil())
        expect(gistEntity?.files.count).to(equal(2))
        expect(gistEntity?.owner).toNot(beNil())
        expect(gistEntity?.isPublic).toNot(beNil())
        expect(gistEntity?.isPublic).to(equal(0))
        expect(gistEntity?.createdAt).toNot(beNil())
    }
}

// MARK: - Testable Entity Protocol

extension GistEntityTest: TestableEntity {
    
    // MARK: - Protocol variable
    
    var localJSON: String {
        get { return _localJSON }
        set { _localJSON = newValue }
    }
    
    // MARK: - Protocol method
    
    func testSuccessFulInit() {
        localJSON = "gist_entity"
        
        expect { try self.jsonDecoder.decode(GistEntity.self, from: self.jsonData) }.toNot(throwError())
        
        let gistEntity = try? jsonDecoder.decode(GistEntity.self, from: jsonData)
        expect(gistEntity).toNot(beNil())
        expect(gistEntity?.id).toNot(beNil())
        expect(gistEntity?.description).toNot(beNil())
        expect(gistEntity?.apiURL).toNot(beNil())
        expect(gistEntity?.htmlURL).toNot(beNil())
        expect(gistEntity?.files).toNot(beNil())
        expect(gistEntity?.owner).toNot(beNil())
        expect(gistEntity?.isPublic).toNot(beNil())
        expect(gistEntity?.createdAt).toNot(beNil())
    }
}




