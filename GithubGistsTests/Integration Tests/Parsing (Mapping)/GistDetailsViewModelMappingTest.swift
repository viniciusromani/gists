//
//  GistDetailsViewModelMappingTest.swift
//  GithubGistsTests
//
//  Created by Vinicius Romani on 30/01/18.
//  Copyright © 2018 Vinicius Romani. All rights reserved.
//

import XCTest
import Nimble

/*
 *  This class is going to test the whole parsing and mapping
 *  integration, from a mocked JSON to the GistViewModel.
 *  This is the map:
 *  1) Read mocked JSON:
 *      - Set JSON's name using _localJSON variable
 *      - Use jsonDecoder to read it and create an entity
 *  2) Map Entity to a Domain Model
 *  3) Map a Domain Model to a ViewModel
 *  PS. All tests results in this class are being mocked from
 *  the json to ensure the integrity of the test case. If a value
 *  changes in the json it should be also changed in the test case
 *  otherwise, it will not pass anymore.
 */

class GistDetailsViewModelMappingTest: XCTestCase {
    
    // MARK: Variables
    
    var entity: GistEntity?
    var model: Gist?
    var viewModel: GistDetailsViewModel?
    private var _localJSON: String = ""
    private var jsonDecoder = JSONDecoder()
    private var gistViewModelMappingTest: GistViewModelMappingTest?
    
    // MARK: - XCTestCase Cycle
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        gistViewModelMappingTest = GistViewModelMappingTest()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Tests
    
    /*
     *  This is going to test a valid json with invalid attributes values.
     *  Parameters we want to cover:
     *  - id should be "3aacd6b893f35c2decdd8bbae9a37a3d"
     *  - name should be "sample-html.md"
     *  - userImageURL should be nil because its value is null
     *  - userName should be "-" because its value is null
     */
    func testInvalidAttributes() {
        localJSON = "nullattributes"
        
        expect { try self.jsonDecoder.decode(GistEntity.self, from: self.jsonData) }.toNot(throwError())
        entity = try? jsonDecoder.decode(GistEntity.self, from: jsonData)
        
        expect(self.entity).toNot(beNil())
        model = try? Gist(mapping: entity!)
        
        expect(self.model).toNot(beNil())
        viewModel = GistDetailsViewModel(mapping: model!)
        
        expect(self.viewModel?.name).to(equal("sample-html.md"))
        expect(self.viewModel?.description).to(equal("-"))
        expect(self.viewModel?.url).to(equal("-"))
        expect(self.viewModel?.language).to(equal("-"))
        expect(self.viewModel?.forks).to(equal("1"))
        expect(self.viewModel?.ownerName).to(equal("-"))
        expect(self.viewModel?.ownerGithubURL).to(equal("-"))
    }
}

extension GistDetailsViewModelMappingTest: TestableMappingIntegration {
    
    // MARK: - Typealias
    
    typealias Entity = GistEntity
    typealias Model = Gist
    typealias ViewModel = GistDetailsViewModel
    
    // MARK: - Protocol variable
    
    var localJSON: String {
        get { return _localJSON }
        set { _localJSON = newValue }
    }
    
    // MARK: - Protocol method
    
    /*
     *  This is testing a valid json with all atributes set.
     *  Those values were taken from the mocked json. Read
     *  the beginning of the file for a detailed explanation.
     */
    func testSuccessfulMapping() {
        localJSON = "gist_entity"
        
        expect { try self.jsonDecoder.decode(GistEntity.self, from: self.jsonData) }.toNot(throwError())
        entity = try? jsonDecoder.decode(GistEntity.self, from: jsonData)
        
        expect(self.entity).toNot(beNil())
        model = try? Gist(mapping: entity!)
        
        expect(self.model).toNot(beNil())
        viewModel = GistDetailsViewModel(mapping: model!)

        expect(self.viewModel?.name).to(equal("sample-html.md"))
        expect(self.viewModel?.description).to(equal("Description"))
        expect(self.viewModel?.url).to(equal("https://gist.github.com/3aacd6b893f35c2decdd8bbae9a37a3d"))
        expect(self.viewModel?.language).to(equal("Markdown"))
        expect(self.viewModel?.forks).to(equal("1"))
        expect(self.viewModel?.ownerName).to(equal("dondempsey"))
        expect(self.viewModel?.ownerGithubURL).to(equal("https://github.com/dondempsey"))
    }
    
    /*
     *  This is the same test as GistViewModelMappingTest
     */
    func testStoreError() {
        gistViewModelMappingTest?.testStoreError()
    }
    
    /*
     *  This is the same test as GistViewModelMappingTest
     */
    func testDomainError() {
        gistViewModelMappingTest?.testDomainError()
    }
}




