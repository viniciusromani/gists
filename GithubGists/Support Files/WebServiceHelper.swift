//
//  WebServiceHelper.swift
//  GithubGists
//
//  Created by Vinicius Romani on 19/12/17.
//  Copyright © 2017 Vinicius Romani. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WebServiceHelper {
    static var headers:[String:String] {
        get {
            return [
                "Content-Type": "application/json"
            ]
        }
    }
    
    internal static let manager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        return Alamofire.SessionManager(configuration: configuration)
    } ()
    
    class func requestWithMethod(_ method: HTTPMethod,
                                 path: String,
                                 parameters: [String: Any]? = nil,
                                 headers: [String: String]? = nil,
                                 completionSuccess: @escaping (_ result: JSON) -> Void,
                                 completionError: @escaping (_ error: Error?) -> Void) {
        
        var userHeader = headers
        let parametersToSend = parameters ?? [:]
        
        if headers == nil {
            userHeader = WebServiceHelper.headers
        }
        
        print("\n⬆️⬆️⬆️ Request to  \(path)")
        print("Parameters: \(parametersToSend)")
        
        let encoding: ParameterEncoding = (method == .get ? URLEncoding.default : JSONEncoding(options: JSONSerialization.WritingOptions.prettyPrinted))
        
        WebServiceHelper.manager.request(path, method: method, parameters: parametersToSend, encoding: encoding, headers: userHeader)
            .responseJSON { response in
                print("⬇️⬇️⬇️ Response Code: \(response.response?.statusCode ?? 0)")
                print("Url: \(path)")
                print("Headers: \(response.response?.allHeaderFields ?? [:])")
                print("Data: \(response.result.value ?? [:])")
                print("Error: \(response.error.debugDescription)\n")
            }
            .response { response in
                let jsonResponse = JSON(data: response.data ?? Data())
                
                if let internalError = handleInternalError(response.error) {
                    completionError(internalError)
                } else {
                    completionSuccess(jsonResponse)
                }
        }
    }
    
    private class func handleInternalError(_ error: Error? = nil) -> Error? {
        if let error = error as? AFError {
            switch error {
            case .invalidURL(let url):
                print("Invalid URL: \(url) - \(error.localizedDescription)")
            case .parameterEncodingFailed(let reason):
                print("Parameter encoding failed: \(error.localizedDescription)")
                print("Failure Reason: \(reason)")
            case .multipartEncodingFailed(let reason):
                print("Multipart encoding failed: \(error.localizedDescription)")
                print("Failure Reason: \(reason)")
            case .responseValidationFailed(let reason):
                print("Response validation failed: \(error.localizedDescription)")
                print("Failure Reason: \(reason)")
                
                switch reason {
                case .dataFileNil, .dataFileReadFailed:
                    print("Downloaded file could not be read")
                case .missingContentType(let acceptableContentTypes):
                    print("Content Type Missing: \(acceptableContentTypes)")
                case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                    print("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
                case .unacceptableStatusCode(let code):
                    print("Response status code was unacceptable: \(code)")
                }
            case .responseSerializationFailed(let reason):
                print("Response serialization failed: \(error.localizedDescription)")
                print("Failure Reason: \(reason)")
            }
            
            print("Underlying error: \(error.underlyingError?.localizedDescription ?? "Unknown")")
            return NSError(domain: error.errorDescription ?? "NA", code: error.responseCode ?? 0, userInfo: nil)
            
        } else if let error = error as? URLError {
            print("URLError occurred: \(error)")
            return NSError(domain: error.localizedDescription, code: error.errorCode, userInfo: error.userInfo)
        } else if let error = error {
            print("Unknown error: \(error)")
            return NSError(domain: "Unknown error", code: 1, userInfo: nil)
        }
        return nil
    }
    
    private class func handleRequestError(_ response: HTTPURLResponse? = nil, json: JSON? = nil) -> Error? {
        
        guard let response = response, response.statusCode > 299,
            let jsonDict = json?.dictionaryValue else { return nil }
        
        var errorDict: [String: JSON]? = nil
        
        if let errorResponse = jsonDict["err"]?.dictionaryValue {
            errorDict = errorResponse
        } else if let errorResponse = jsonDict["error"]?.dictionaryValue {
            errorDict = errorResponse
        }
        
        guard let error = errorDict,
            let message = error["message"]?.string,
            let name = error["name"]?.string else {
                return NSError(domain: "Unexpected", code: 500, userInfo: nil)
        }
        
        let userName: String? = response.allHeaderFields["userName"] as? String
        let owner: String? = response.allHeaderFields["owner"] as? String
        let condition: String? = response.allHeaderFields["condition"] as? String
        
        return NSError(domain: name, code: response.statusCode, userInfo:
            [NSLocalizedDescriptionKey: message,
             "userName": userName ?? "",
             "owner": owner ?? "",
             "condition": condition ?? ""])
    }
}
