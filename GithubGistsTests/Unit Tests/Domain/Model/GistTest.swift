//
//  GistTest.swift
//  GithubGistsTests
//
//  Created by Vinicius Romani on 25/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import XCTest

/*
 * This class is going to test Gist and
 * its respective mapper described in Gist+Mappable.
 */

class GistTest: XCTestCase {
    
    // MARK: Variables
    
    var entity: GistEntity?
    private var userEntity: UserEntity?
    private var fileEntity: FileEntity!
    
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
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Tests
    
    /*
     * Testing a Gist with an invalid id, it should not parse and throw an error
     */
    func testInvalidId() {
        var gistEntity = GistEntity(id: "",
                                    description: "Description",
                                    apiURL: "https://api.github.com/gists/3aacd6b893f35c2decdd8bbae9a37a3d",
                                    htmlURL: "https://gist.github.com/3aacd6b893f35c2decdd8bbae9a37a3d",
                                    files: [fileEntity],
                                    owner: userEntity,
                                    isPublic: 1,
                                    createdAt: Date())
        
        XCTAssertThrowsError(try Gist(mapping: gistEntity))
        
        gistEntity = GistEntity(id: "  ",
                                description: "Description",
                                apiURL: "https://api.github.com/gists/3aacd6b893f35c2decdd8bbae9a37a3d",
                                htmlURL: "https://gist.github.com/3aacd6b893f35c2decdd8bbae9a37a3d",
                                files: [fileEntity],
                                owner: userEntity,
                                isPublic: 1,
                                createdAt: Date())
        
        XCTAssertThrowsError(try Gist(mapping: gistEntity))
    }
    
    /*
     * Testing a Gist without files, it should not parse and throw an error
     */
    func testNoFileAndAOwnerMapper() {
        let gistEntity = GistEntity(id: "3aacd6b893f35c2decdd8bbae9a37a3d",
                                    description: "Description",
                                    apiURL: "https://api.github.com/gists/3aacd6b893f35c2decdd8bbae9a37a3d",
                                    htmlURL: "https://gist.github.com/3aacd6b893f35c2decdd8bbae9a37a3d",
                                    files: [],
                                    owner: userEntity,
                                    isPublic: 1,
                                    createdAt: Date())
        
        XCTAssertThrowsError(try Gist(mapping: gistEntity))
    }
    
    func testOneFileAndNoOwnerMapper() {
        
    }
    
    func testTwoFilesAndAOnwerMapper() {
        
    }
    
    func testNoDateMapper() {
        
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
                            createdAt: Date())
        var gist: Gist
        
        do {
            gist = try Gist(mapping: entity!)
            
            XCTAssert(gist.id == entity?.id)
            XCTAssertNotNil(gist.description)
            XCTAssert(gist.description == entity?.description)
            XCTAssertNotNil(gist.apiURL)
            let entityAPIURL = URL(string: entity?.apiURL ?? "")
            XCTAssert(gist.apiURL == entityAPIURL)
            XCTAssertNotNil(gist.htmlURL)
            let entityHTMLURL = URL(string: entity?.htmlURL ?? "")
            XCTAssert(gist.htmlURL == entityHTMLURL)
            XCTAssert(gist.files.count == entity?.files.count)
            XCTAssertNotNil(gist.owner)
            let entityOwnerId = entity?.owner?.id != nil ? "\(entity!.owner!.id)": "0"
            XCTAssert(gist.owner?.id == entityOwnerId)
            XCTAssert(gist.owner?.userName == entity?.owner?.userName)
            XCTAssertNotNil(gist.isPublic)
            let entityIsPublic = Bool(truncating: (entity?.isPublic ?? 0) as NSNumber)
            XCTAssert(gist.isPublic == entityIsPublic)
            XCTAssertNotNil(gist.createdAt)
            XCTAssert(gist.createdAt == entity?.createdAt)
        } catch {
            XCTFail()
        }
    }
}


