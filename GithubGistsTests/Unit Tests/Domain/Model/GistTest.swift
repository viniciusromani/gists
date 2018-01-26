//
//  GistTest.swift
//  GithubGistsTests
//
//  Created by Vinicius Romani on 25/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import XCTest
import Nimble

/*
 * This class is going to test Gist and
 * its respective mapper described in Gist+Mappable.
 */

class GistTest: XCTestCase {
    
    // MARK: Variables
    
    var entity: GistEntity?
    private var userEntity: UserEntity?
    private var fileEntity: FileEntity!
    private var dateCaseTest: DateUtilsTest?
    
    // MARK: - XCTestCase Cycle
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        userEntity = UserEntity(id: 34760928,
                                userName: "VictoriaDem",
                                userGithubURL: "https://github.com/VictoriaDem",
                                avatarURL: "https://avatars0.githubusercontent.com/u/34760928?v=4")
        
        fileEntity = FileEntity(name: "ring.erlang",
                                size: 932.0,
                                language: "Erlang",
                                url: "https://gist.githubusercontent.com/raw/365370/8c4d2d43d178df44f4c03a7f2ac0ff512853564e/ring.erl")
        
        dateCaseTest = DateUtilsTest()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        entity = nil
        userEntity = nil
        dateCaseTest = nil
    }
    
    // MARK: - Tests
    
    /*
     * Testing a Gist with an invalid id, it should not parse and throw an error
     */
    func testInvalidId() {
        entity = GistEntity(id: "",
                            description: "Description",
                            apiURL: "https://api.github.com/gists/3aacd6b893f35c2decdd8bbae9a37a3d",
                            htmlURL: "https://gist.github.com/3aacd6b893f35c2decdd8bbae9a37a3d",
                            files: [fileEntity],
                            owner: userEntity,
                            isPublic: 1,
                            createdAt: "2010-04-14T02:15:15Z")
        expect { try Gist(mapping: entity!) }.to(throwError())
        
        entity = GistEntity(id: "  ",
                            description: "Description",
                            apiURL: "https://api.github.com/gists/3aacd6b893f35c2decdd8bbae9a37a3d",
                            htmlURL: "https://gist.github.com/3aacd6b893f35c2decdd8bbae9a37a3d",
                            files: [fileEntity],
                            owner: userEntity,
                            isPublic: 1,
                            createdAt: "2010-04-14T02:15:15Z")
        expect { try Gist(mapping: entity!) }.to(throwError())
    }
    
    /*
     * Testing a Gist without files, it should not parse and throw an error
     */
    func testNoFileAndAOwnerMapper() {
        entity = GistEntity(id: "3aacd6b893f35c2decdd8bbae9a37a3d",
                            description: "Description",
                            apiURL: "https://api.github.com/gists/3aacd6b893f35c2decdd8bbae9a37a3d",
                            htmlURL: "https://gist.github.com/3aacd6b893f35c2decdd8bbae9a37a3d",
                            files: [],
                            owner: userEntity,
                            isPublic: 1,
                            createdAt: "2010-04-14T02:15:15Z")
        expect { try Gist(mapping: entity!) }.to(throwError())
    }
    
    /*
     *  Testing a Gist with one file and no onwer.
     *  Parameters we want to cover as well:
     *  - apiURL should be nil (because the value is invalid)
     *  - htmlURL should be nil (because the value is invalid)
     *  - owner should not exist
     *  - isPublic should be true
     */
    func testOneFileAndNoOwnerMapper() {
        entity = GistEntity(id: "3aacd6b893f35c2decdd8bbae9a37a3d",
                            description: "Description",
                            apiURL: "  ",
                            htmlURL: "https: //gist.github.com/3aacd6b893f35c2decdd8bbae9a37a3d",
                            files: [fileEntity],
                            owner: nil,
                            isPublic: 1,
                            createdAt: "2010-04-14T02:15:15Z")
        var gist: Gist
        expect { try Gist(mapping: entity!) }.toNot(throwError())
        
        do {
            gist = try Gist(mapping: entity!)
            
            expect(gist.id).to(equal(entity?.id))
            expect(gist.description).toNot(beNil())
            expect(gist.apiURL).to(beNil())
            expect(gist.htmlURL).to(beNil())
            expect(gist.files.count).to(equal(entity?.files.count))
            expect(gist.owner).to(beNil())
            expect(gist.isPublic).toNot(beNil())
            let entityIsPublic = Bool(truncating: (entity?.isPublic ?? 0) as NSNumber)
            expect(gist.isPublic).to(equal(entityIsPublic))
        } catch {
            XCTFail()
        }
    }
    
    /*
     *  Testing a Gist with two files and a onwer.
     *  Parameters we want to cover as well:
     *  - apiURL should be nil (because the value is an empty string)
     *  - htmlURL should be nil (because the value is null)
     *  - owner should exist
     *  - isPublic should be false
     */
    func testTwoFilesAndAOnwerMapper() {
        entity = GistEntity(id: "3aacd6b893f35c2decdd8bbae9a37a3d",
                            description: "Description",
                            apiURL: "",
                            htmlURL: nil,
                            files: [fileEntity, fileEntity],
                            owner: userEntity,
                            isPublic: 0,
                            createdAt: "2010-04-14T02:15:15Z")
        var gist: Gist
        expect { try Gist(mapping: entity!) }.toNot(throwError())
        
        do {
            gist = try Gist(mapping: entity!)
            
            expect(gist.id).to(equal(entity?.id))
            expect(gist.description).toNot(beNil())
            expect(gist.apiURL).to(beNil())
            expect(gist.htmlURL).to(beNil())
            expect(gist.files.count).to(equal(entity?.files.count))
            expect(gist.isPublic).toNot(beNil())
            let entityIsPublic = Bool(truncating: (entity?.isPublic ?? 0) as NSNumber)
            expect(gist.isPublic).to(equal(entityIsPublic))
        } catch {
            fail("Could not create gist model from entity")
        }
    }
    
    /*
     *  Testing a Gist with a invalid date.
     *  Parameters we want to cover as well:
     *  - description should be nil (because the value is null)
     *  - apiURL should be nil (because the value is null)
     *  - htmlURL should be nil (because the value is null)
     *  - owner should be nil (because the value is null)
     *  - isPublic should be false
     *  - createAt should be nil (because the value is null)
     */
    func testNoDateMapper() {
        entity = GistEntity(id: "3aacd6b893f35c2decdd8bbae9a37a3d",
                            description: nil,
                            apiURL: nil,
                            htmlURL: nil,
                            files: [fileEntity],
                            owner: nil,
                            isPublic: 0,
                            createdAt: nil)
        var gist: Gist
        expect { try Gist(mapping: entity!) }.toNot(throwError())
        
        do {
            gist = try Gist(mapping: entity!)
            
            expect(gist.id).to(equal(entity?.id))
            expect(gist.description).to(beNil())
            expect(gist.apiURL).to(beNil())
            expect(gist.htmlURL).to(beNil())
            expect(gist.createdAt).to(beNil())
        } catch {
            fail("Could not create gist model from entity")
        }
    }
}

// MARK: - TestableModel Protocol Conformance

extension GistTest: TestableModel {
    
    // MARK: - Typealias
    
    typealias Entity = GistEntity
    
    // MARK: - Successfull test
    
    /*
     * This method is going to test a successfull mapping
     * with all attributes set.
     */
    func testSuccessFullMapping() {
        entity = GistEntity(id: "3aacd6b893f35c2decdd8bbae9a37a3d",
                            description: "Description",
                            apiURL: "https://api.github.com/gists/3aacd6b893f35c2decdd8bbae9a37a3d",
                            htmlURL: "https://gist.github.com/3aacd6b893f35c2decdd8bbae9a37a3d",
                            files: [fileEntity],
                            owner: userEntity,
                            isPublic: 1,
                            createdAt: "2010-04-14T02:15:15Z")
        var gist: Gist
        expect { try Gist(mapping: entity!) }.toNot(throwError())
        
        do {
            gist = try Gist(mapping: entity!)
            
            expect(gist.id).to(equal(entity?.id))
            expect(gist.description).toNot(beNil())
            expect(gist.description).to(equal(entity?.description))
            expect(gist.apiURL).toNot(beNil())
            let entityAPIURL = URL(string: entity?.apiURL ?? "")
            expect(gist.apiURL).to(equal(entityAPIURL))
            expect(gist.htmlURL).toNot(beNil())
            let entityHTMLURL = URL(string: entity?.htmlURL ?? "")
            expect(gist.htmlURL).to(equal(entityHTMLURL))
            expect(gist.files.count).to(equal(entity?.files.count))
            expect(gist.owner).toNot(beNil())
            let entityOwnerId = entity?.owner?.id != nil ? "\(entity!.owner!.id)": "0"
            expect(gist.owner?.id).to(equal(entityOwnerId))
            expect(gist.owner?.userName).to(equal(entity?.owner?.userName))
            expect(gist.isPublic).toNot(beNil())
            let entityIsPublic = Bool(truncating: (entity?.isPublic ?? 0) as NSNumber)
            expect(gist.isPublic).to(equal(entityIsPublic))
            dateCaseTest?.validate(dateString: entity?.createdAt)
            let date = dateCaseTest?.isoDate
            expect(gist.createdAt).to(equal(date))
        } catch {
            fail("Could not create gist model from entity")
        }
    }
}


