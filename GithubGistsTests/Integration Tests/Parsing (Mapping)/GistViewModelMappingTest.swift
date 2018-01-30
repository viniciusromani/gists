//
//  GistViewModelMappingTest.swift
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

class GistViewModelMappingTest: XCTestCase {
    
    // MARK: Variables
    
    var entity: GistEntity?
    var model: Gist?
    var viewModel: GistViewModel?
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
     *  This is going to test a valid json with invalid attributes values.
     *  Parameters we want to cover:
     *  - id should be "3aacd6b893f35c2decdd8bbae9a37a3d"
     *  - name should be "sample-html.md"
     *  - userImageURL should be nil because its value is true
     *  - userName should be "-" because its value is []
     */
    func testInvalidAttributes() {
        localJSON = "nullattributes"
        
        expect { try self.jsonDecoder.decode(GistEntity.self, from: self.jsonData) }.toNot(throwError())
        entity = try? jsonDecoder.decode(GistEntity.self, from: jsonData)
        
        expect(self.entity).toNot(beNil())
        model = try? Gist(mapping: entity!)
        
        expect(self.model).toNot(beNil())
        viewModel = GistViewModel(mapping: model!)
        
        expect(self.viewModel).toNot(beNil())
        expect(self.viewModel?.id).to(equal("3aacd6b893f35c2decdd8bbae9a37a3d"))
        expect(self.viewModel?.name).to(equal("sample-html.md"))
        expect(self.viewModel?.userImageURL).to(beNil())
        expect(self.viewModel?.userName).to(equal("-"))
    }
}

extension GistViewModelMappingTest: TestableMappingIntegration {
    
    // MARK: - Typealias
    
    typealias Entity = GistEntity
    typealias Model = Gist
    typealias ViewModel = GistViewModel
    
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
        viewModel = GistViewModel(mapping: model!)
        
        expect(self.viewModel).toNot(beNil())
        expect(self.viewModel?.id).to(equal("3aacd6b893f35c2decdd8bbae9a37a3d"))
        expect(self.viewModel?.name).to(equal("sample-html.md"))
        expect(self.viewModel?.userImageURL).to(equal(URL(string: "https://avatars3.githubusercontent.com/u/4392765?v=4")!))
        expect(self.viewModel?.userName).to(equal("dondempsey"))
    }
    
    /*
     *  This is testing an invalid json.
     *  It should no parse and raise an error at the store layer
     */
    func testStoreError() {
        localJSON = "withoutidkey"
        
        expect { try self.jsonDecoder.decode(GistEntity.self, from: self.jsonData) }.to(throwError())
        entity = try? jsonDecoder.decode(GistEntity.self, from: jsonData)
        expect(self.entity).to(beNil())
    }
    
    /*
     *  This is testing a valid json with an invalid id value
     *  and at the second time, no files related.
     *  It should parse until the domain layer because of the
     *  business rule (which is applied at this layer).
     */
    func testDomainError() {
        localJSON = "withinvalidid"
        
        expect { try self.jsonDecoder.decode(GistEntity.self, from: self.jsonData) }.toNot(throwError())
        entity = try? jsonDecoder.decode(GistEntity.self, from: jsonData)
        expect(self.entity).toNot(beNil())
        
        expect { try Gist(mapping: self.entity!) }.to(throwError())
        model = try? Gist(mapping: self.entity!)
        expect(self.model).to(beNil())
        
        localJSON = "nofiles"
        
        expect { try self.jsonDecoder.decode(GistEntity.self, from: self.jsonData) }.toNot(throwError())
        entity = try? jsonDecoder.decode(GistEntity.self, from: jsonData)
        expect(self.entity).toNot(beNil())
        
        expect { try Gist(mapping: self.entity!) }.to(throwError())
        model = try? Gist(mapping: self.entity!)
        expect(self.model).to(beNil())
    }
}




