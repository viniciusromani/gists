//
//  FileTest.swift
//  GithubGistsTests
//
//  Created by Vinicius Romani on 25/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import XCTest
import Nimble

/*
 * This class is going to test File and
 * its respective mapper described in File+Mappable.
 */

class FileTest: XCTestCase {
    
    // MARK: Variables
    
    var entity: FileEntity?
    
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
     * Invalid name testing, it should not parse and throw an error.
     */
    func testInvalidName() {
        entity = FileEntity(name: "",
                            size: 932.0,
                            language: "Erlang",
                            url: "https://gist.githubusercontent.com/raw/365370/8c4d2d43d178df44f4c03a7f2ac0ff512853564e/ring.erl")
        expect { try File(mapping: self.entity!) }.to(throwError())
        
        entity = FileEntity(name: "  ",
                            size: 932.0,
                            language: "Erlang",
                            url: "https://gist.githubusercontent.com/raw/365370/8c4d2d43d178df44f4c03a7f2ac0ff512853564e/ring.erl")
        expect { try File(mapping: self.entity!) }.to(throwError())
    }
    
    /*
     * Invalid size testing, it should not parse and throw an error.
     */
    func testInvalidSize() {
        entity = FileEntity(name: "ring.erlang",
                            size: 0.0,
                            language: "Erlang",
                            url: "https://gist.githubusercontent.com/raw/365370/8c4d2d43d178df44f4c03a7f2ac0ff512853564e/ring.erl")
        expect { try File(mapping: self.entity!) }.to(throwError())
        
        entity = FileEntity(name: "ring.erlang",
                            size: -120.3,
                            language: "Erlang",
                            url: "https://gist.githubusercontent.com/raw/365370/8c4d2d43d178df44f4c03a7f2ac0ff512853564e/ring.erl")
        expect { try File(mapping: self.entity!) }.to(throwError())
    }
    
    /*
     * Invalid name and size testing, it should not parse and throw an error.
     */
    func testInvalidNameAndSize() {
        entity = FileEntity(name: "",
                            size: -1.0,
                            language: "Erlang",
                            url: "https://gist.githubusercontent.com/raw/365370/8c4d2d43d178df44f4c03a7f2ac0ff512853564e/ring.erl")
        expect { try File(mapping: self.entity!) }.to(throwError())
        
        entity = FileEntity(name: "  ",
                            size: -0.0,
                            language: "Erlang",
                            url: "https://gist.githubusercontent.com/raw/365370/8c4d2d43d178df44f4c03a7f2ac0ff512853564e/ring.erl")
        expect { try File(mapping: self.entity!) }.to(throwError())
    }
    
    /*
     * Invalid attributes testing, it should not parse and throw an error.
     */
    func testInvalidAttributes() {
        entity = FileEntity(name: "ring.erlang",
                            size: 932.0,
                            language: nil,
                            url: nil)
        var file: File
        expect { try File(mapping: self.entity!) }.toNot(throwError())
        
        do {
            file = try File(mapping: entity!)
            
            expect(file.name).to(equal(entity?.name))
            expect(file.size).to(equal(entity?.size))
            expect(file.language).to(beNil())
            expect(file.url).to(beNil())
        } catch {
            fail("Could not create file model from entity")
        }
    }
}

// MARK: - TestableModel Protocol Conformance

extension FileTest: TestableModel {
    
    // MARK: - Typealias
    
    typealias Entity = FileEntity
    
    // MARK: - Successfull test
    
    /*
     * This method is going to test a successfull mapping
     * with all attributes set.
     */
    func testSuccessFullMapping() {
        entity = FileEntity(name: "ring.erlang",
                            size: 932.0,
                            language: "Erlang",
                            url: "https://gist.githubusercontent.com/raw/365370/8c4d2d43d178df44f4c03a7f2ac0ff512853564e/ring.erl")
        var file: File
        expect { try File(mapping: self.entity!) }.toNot(throwError())
        
        do {
            file = try File(mapping: entity!)
            
            expect(file.name).to(equal(entity?.name))
            expect(file.size).to(equal(entity?.size))
            expect(file.language).toNot(beNil())
            expect(file.language).to(equal(entity?.language))
            expect(file.url).toNot(beNil())
            let entityURL = URL(string: entity?.url ?? "")
            expect(file.url).to(equal(entityURL))
        } catch {
            fail("Could not create file model from entity")
        }
    }
}





