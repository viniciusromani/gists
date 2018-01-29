//
//  GistViewModelTest.swift
//  GithubGistsTests
//
//  Created by Vinicius Romani on 29/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import XCTest
import Nimble

class GistViewModelTest: XCTestCase {
    
    // MARK: Variables
    
    var model: Gist?
    private var userEntity: UserEntity?
    private var userModel: User?
    private var fileEntity: FileEntity!
    private var fileModel: File!
    private var secondFileEntity: FileEntity!
    private var secondFileModel: File!
    
    // MARK: - XCTestCase Cycle
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        userEntity = UserEntity(id: 34760928,
                                userName: "VictoriaDem",
                                userGithubURL: "https://github.com/VictoriaDem",
                                avatarURL: "https://avatars0.githubusercontent.com/u/34760928?v=4")
        expect { try User(mapping: self.userEntity) }.toNot(throwError())
        
        fileEntity = FileEntity(name: "ring.erlang",
                                size: 932.0,
                                language: "Erlang",
                                url: "https://gist.githubusercontent.com/raw/365370/8c4d2d43d178df44f4c03a7f2ac0ff512853564e/ring.erl")
        expect { try File(mapping: self.fileEntity) }.toNot(throwError())
        
        secondFileEntity = FileEntity(name: "Test.swift",
                                      size: 120.0,
                                      language: "Swift",
                                      url: "https://gist.githubusercontent.com/raw/365370/8c4d2d43d178df44f4c03a7f2ac0ff512853564e/Test.swift")
        expect { try File(mapping: self.secondFileEntity) }.toNot(throwError())
        
        do {
            userModel = try User(mapping: userEntity)
            fileModel = try File(mapping: fileEntity)
            secondFileModel = try File(mapping: secondFileEntity)
        } catch let _ {
            fail("Could not create user or file model from entity")
        }
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Tests
    
    /*
     *  Parameters we want to cover:
     *  - name should be empty (because there is no file in model's files array)
     *  - userImageURL should be nil (because there is no owner)
     *  - userName should be "-" (because there is no owner and that is the default value)
     */
    func testInvalidAttributes() {
        model = Gist(id: "3aacd6b893f35c2decdd8bbae9a37a3d",
                     description: nil,
                     apiURL: nil,
                     htmlURL: nil,
                     files: [],
                     owner: nil,
                     isPublic: nil,
                     createdAt: nil)
        let gistViewModel = GistViewModel(mapping: model!)
        
        expect(gistViewModel.id).to(equal(model?.id))
        expect(gistViewModel.name).to(beEmpty())
        expect(gistViewModel.userImageURL).to(beNil())
        expect(gistViewModel.userName).to(equal("-"))
    }
    
    /*
     *  Parameters we want to cover:
     *  - name should be equal to the first item of files array
     */
    func testTwoFilesArray() {
        model = Gist(id: "3aacd6b893f35c2decdd8bbae9a37a3d",
                     description: nil,
                     apiURL: nil,
                     htmlURL: nil,
                     files: [fileModel, secondFileModel],
                     owner: nil,
                     isPublic: nil,
                     createdAt: nil)
        let gistViewModel = GistViewModel(mapping: model!)
        
        expect(gistViewModel.id).to(equal(model?.id))
        expect(gistViewModel.name).to(equal(model?.files.first?.name))
    }
}

extension GistViewModelTest: TestableViewModel {
    
    // MARK: - Typealias
    
    typealias Model = Gist
    
    // MARK: - Successfull test
    
    /*
     * This method is going to test a successfull mapping
     * with all attributes set.
     */
    func testSuccessFullMapping() {
        model = Gist(id: "3aacd6b893f35c2decdd8bbae9a37a3d",
                     description: "Description",
                     apiURL: URL(string: "https://api.github.com/gists/3aacd6b893f35c2decdd8bbae9a37a3d")!,
                     htmlURL: URL(string: "https://gist.github.com/3aacd6b893f35c2decdd8bbae9a37a3d")!,
                     files: [fileModel],
                     owner: userModel,
                     isPublic: true,
                     createdAt: Date())
        let gistViewModel = GistViewModel(mapping: model!)
        
        expect(gistViewModel.id).to(equal(model?.id))
        expect(gistViewModel.name).to(equal(model?.files.first?.name))
        expect(gistViewModel.userImageURL).toNot(beNil())
        expect(gistViewModel.userImageURL).to(equal(model?.owner?.avatarURL))
        expect(gistViewModel.userName).to(equal(model?.owner?.userName))
    }
}



