//
//  UserEntityTest.swift
//  GithubGistsTests
//
//  Created by Vinicius Romani on 14/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import XCTest
import Nimble

/*
 * This class is going to test UserEntity and
 * its respective mapper described in UserEntity+Mappable.
 */

class UserEntityTest: XCTestCase {
    
    // MARK: Variables
    
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
     *  It should parse because it has an id.
     *  This is also testing a json with no
     *  attributes being sent.
     */
    func testNoValidAttributesJSON() {
        localJSON = "withid_withoutatt"
        
        // It is a valid JSON because it has id
        expect { try self.jsonDecoder.decode(UserEntity.self, from: self.jsonData) }.toNot(throwError())
        
        let userEntity = try? jsonDecoder.decode(UserEntity.self, from: jsonData)
        expect(userEntity).toNot(beNil())
        expect(userEntity?.id).toNot(beNil())
        expect(userEntity?.userName).to(beNil())
        expect(userEntity?.userGithubURL).to(beNil())
        expect(userEntity?.avatarURL).to(beNil())
    }
    
    /*
     *  It should not parse because it does not have and id.
     */
    func testNoIdAttribute() {
        localJSON = "withoutid_withatt"
        
        // It is an invalid JSON because it does not have id
        expect { try self.jsonDecoder.decode(UserEntity.self, from: self.jsonData) }.to(throwError())
        
        let userEntity = try? jsonDecoder.decode(UserEntity.self, from: jsonData)
        expect(userEntity).to(beNil())
    }
    
    /*
     *  It should parse because the id is being sent.
     *  All other parameters exist in json but their
     *  values are null.
     */
    func testInvalidIdValueJSON() {
        localJSON = "withwrongid_withatt"
        
        // It is a valid JSON because it has id
        expect { try self.jsonDecoder.decode(UserEntity.self, from: self.jsonData) }.toNot(throwError())
        
        let userEntity = try? jsonDecoder.decode(UserEntity.self, from: jsonData)
        expect(userEntity).toNot(beNil())
        expect(userEntity?.id).toNot(beNil())
        expect(userEntity?.userName).to(beNil())
        expect(userEntity?.userGithubURL).to(beNil())
        expect(userEntity?.avatarURL).to(beNil())
    }
}

// MARK: - Testable Entity Protocol

extension UserEntityTest: TestableEntity {
    
    // MARK: - Protocol variable
    
    var localJSON: String {
        get { return _localJSON }
        set { _localJSON = newValue }
    }
    
    // MARK: - Protocol method
    
    func testSuccessFulInit() {
        localJSON = "user_entity"
        
        expect { try self.jsonDecoder.decode(UserEntity.self, from: self.jsonData) }.toNot(throwError())
        
        let userEntity = try? jsonDecoder.decode(UserEntity.self, from: jsonData)
        expect(userEntity).toNot(beNil())
        expect(userEntity?.id).toNot(beNil())
        expect(userEntity?.userName).toNot(beNil())
        expect(userEntity?.userGithubURL).toNot(beNil())
        expect(userEntity?.avatarURL).toNot(beNil())
    }
}
