//
//  GistMapperTest.swift
//  GithubGistsTests
//
//  Created by Vinicius Romani on 26/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import XCTest

class GistMapperTest: XCTestCase {
    
    // MARK: - Variables
    
    private var userEntity: UserEntity?
    private var fileEntity: FileEntity!
    
    // MARK: - XCTestCase Cycle
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        userEntity = UserEntity(id: "34760928",
                                userName: "VictoriaDem",
                                userGithubURL: URL(string: "https://github.com/VictoriaDem"),
                                avatarURL: URL(string: "https://avatars0.githubusercontent.com/u/34760928?v=4"))
        
        fileEntity = FileEntity(name: "ring.erlang",
                                size: 932.0,
                                language: "Erlang",
                                url: URL(string: "https://gist.githubusercontent.com/raw/365370/8c4d2d43d178df44f4c03a7f2ac0ff512853564e/ring.erl"))
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Tests
    
    /*
     *  The goal is testing the mapper init method for an entity
     *  with all attributes
     */
    func testValidValuesMapper() {
        let gistEntity = GistEntity(id: "3aacd6b893f35c2decdd8bbae9a37a3d",
                                    description: "Description",
                                    apiURL: URL(string: "https://api.github.com/gists/3aacd6b893f35c2decdd8bbae9a37a3d"),
                                    htmlURL: URL(string: "https://gist.github.com/3aacd6b893f35c2decdd8bbae9a37a3d"),
                                    files: [fileEntity],
                                    owner: userEntity,
                                    isPublic: true,
                                    createdAt: Date())
        var gist: Gist
        do {
            gist = try Gist(mapping: gistEntity)
            
            XCTAssert(gist.id == gistEntity.id)
            XCTAssertNotNil(gist.description)
            XCTAssert(gist.description == gistEntity.description)
            XCTAssertNotNil(gist.apiURL)
            XCTAssert(gist.apiURL == gistEntity.apiURL)
            XCTAssertNotNil(gist.htmlURL)
            XCTAssert(gist.htmlURL == gistEntity.htmlURL)
            XCTAssert(gist.files.count == gistEntity.files.count)
            XCTAssertNotNil(gist.owner)
            XCTAssert(gist.owner?.id == gistEntity.owner?.id)
            XCTAssert(gist.owner?.userName == gistEntity.owner?.userName)
            XCTAssertNotNil(gist.isPublic)
            XCTAssert(gist.isPublic == gistEntity.isPublic)
            XCTAssertNotNil(gist.createdAt)
            XCTAssert(gist.createdAt == gistEntity.createdAt)
        } catch {
            XCTFail()
        }
    }
    
    func testNoFileAndAOwnerMapper() {
        let gistEntity = GistEntity(id: "3aacd6b893f35c2decdd8bbae9a37a3d",
                                    description: nil,
                                    apiURL: URL(string: "https://api.github.com/gists/3aacd6b893f35c2decdd8bbae9a37a3d"),
                                    htmlURL: URL(string: "https://gist.github.com/3aacd6b893f35c2decdd8bbae9a37a3d"),
                                    files: [],
                                    owner: userEntity,
                                    isPublic: false,
                                    createdAt: Date())
        
        XCTAssertThrowsError(try Gist(mapping: gistEntity))
    }
    
    func testOneFileAndNoOwnerMapper() {
        let gistEntity = GistEntity(id: "3aacd6b893f35c2decdd8bbae9a37a3d",
                                    description: "Description",
                                    apiURL: nil,
                                    htmlURL: URL(string: "https://gist.github.com/3aacd6b893f35c2decdd8bbae9a37a3d"),
                                    files: [fileEntity],
                                    owner: nil,
                                    isPublic: true,
                                    createdAt: Date())
        var gist: Gist
        do {
            gist = try Gist(mapping: gistEntity)
            
            XCTAssert(gist.id == gistEntity.id)
            XCTAssertNotNil(gist.description)
            XCTAssert(gist.description == gistEntity.description)
            XCTAssertNil(gist.apiURL)
            XCTAssert(gist.apiURL == gistEntity.apiURL)
            XCTAssertNotNil(gist.htmlURL)
            XCTAssert(gist.htmlURL == gistEntity.htmlURL)
            XCTAssert(gist.files.count == gistEntity.files.count)
            XCTAssertNil(gist.owner)
            XCTAssertNotNil(gist.isPublic)
            XCTAssert(gist.isPublic == gistEntity.isPublic)
            XCTAssertNotNil(gist.createdAt)
            XCTAssert(gist.createdAt == gistEntity.createdAt)
        } catch {
            XCTFail()
        }
    }
    
    func testTwoFilesAndAOnwerMapper() {
        let gistEntity = GistEntity(id: "3aacd6b893f35c2decdd8bbae9a37a3d",
                                    description: "Description",
                                    apiURL: URL(string: "https://api.github.com/gists/3aacd6b893f35c2decdd8bbae9a37a3d"),
                                    htmlURL: nil,
                                    files: [fileEntity, fileEntity],
                                    owner: userEntity,
                                    isPublic: nil,
                                    createdAt: Date())
        var gist: Gist
        do {
            gist = try Gist(mapping: gistEntity)
            
            XCTAssert(gist.id == gistEntity.id)
            XCTAssertNotNil(gist.description)
            XCTAssert(gist.description == gistEntity.description)
            XCTAssertNotNil(gist.apiURL)
            XCTAssert(gist.apiURL == gistEntity.apiURL)
            XCTAssertNil(gist.htmlURL)
            XCTAssert(gist.htmlURL == gistEntity.htmlURL)
            XCTAssert(gist.files.count == gistEntity.files.count)
            XCTAssertNotNil(gist.owner)
            XCTAssert(gist.owner?.id == gistEntity.owner?.id)
            XCTAssert(gist.owner?.userName == gistEntity.owner?.userName)
            XCTAssertNil(gist.isPublic)
            XCTAssertNotNil(gist.createdAt)
            XCTAssert(gist.createdAt == gistEntity.createdAt)
        } catch {
            XCTFail()
        }
    }
    
    func testNoDateMapper() {
        let gistEntity = GistEntity(id: "3aacd6b893f35c2decdd8bbae9a37a3d",
                                    description: "Description",
                                    apiURL: URL(string: "https://api.github.com/gists/3aacd6b893f35c2decdd8bbae9a37a3d"),
                                    htmlURL: URL(string: "https://gist.github.com/3aacd6b893f35c2decdd8bbae9a37a3d"),
                                    files: [fileEntity, fileEntity],
                                    owner: userEntity,
                                    isPublic: true,
                                    createdAt: nil)
        var gist: Gist
        do {
            gist = try Gist(mapping: gistEntity)
            
            XCTAssert(gist.id == gistEntity.id)
            XCTAssertNotNil(gist.description)
            XCTAssert(gist.description == gistEntity.description)
            XCTAssertNotNil(gist.apiURL)
            XCTAssert(gist.apiURL == gistEntity.apiURL)
            XCTAssertNotNil(gist.htmlURL)
            XCTAssert(gist.htmlURL == gistEntity.htmlURL)
            XCTAssert(gist.files.count == gistEntity.files.count)
            XCTAssertNotNil(gist.owner)
            XCTAssert(gist.owner?.id == gistEntity.owner?.id)
            XCTAssert(gist.owner?.userName == gistEntity.owner?.userName)
            XCTAssertNotNil(gist.isPublic)
            XCTAssert(gist.isPublic == gistEntity.isPublic)
            XCTAssertNil(gist.createdAt)
        } catch {
            XCTFail()
        }
    }
}
