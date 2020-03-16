// Copyright 2018-2020 Amazon.com, Inc. or its affiliates. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.
// A copy of the License is located at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// or in the "license" file accompanying this file. This file is distributed
// on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
// express or implied. See the License for the specific language governing
// permissions and limitations under the License.
//
//  AWSClientInvocationTraceContext.swift
//  SmokeAWSHttp
//
import Foundation
import Logging
import SmokeHTTPClient
import AsyncHTTPClient
import NIOHTTP1

private let xAmzRequestId = "x-amz-request-id"
private let xAmzId2 = "x-amz-id-2"

/**
  A type conforming to the `InvocationTraceContext` protocol, sutiable for AWS clients. This implementation will log the input to and output from the outgoing request,
  along with x-amz-request-id and x-amz-id-2" headers if present.
 */
public struct AWSClientInvocationTraceContext: InvocationTraceContext {
    public typealias OutwardsRequestContext = String
        
    public init() {
        
    }
    
    public func handleOutwardsRequestStart(method: HTTPMethod, uri: String, logger: Logger, internalRequestId: String,
                                           headers: inout HTTPHeaders, bodyData: Data) -> String {
        logger.debug("Starting outgoing \(method) request to endpoint '\(uri)' with body: \(bodyData.debugString)")
        
        return ""
    }
    
    public func handleOutwardsRequestSuccess(outwardsRequestContext: String?, logger: Logger, internalRequestId: String,
                                             response: HTTPClient.Response, bodyData: Data?) {
        let logLine = getLogLine(successfullyCompletedRequest: true, response: response, bodyData: bodyData)
        
        logger.debug("\(logLine)")
    }
    
    public func handleOutwardsRequestFailure(outwardsRequestContext: String?, logger: Logger, internalRequestId: String,
                                             response: HTTPClient.Response?, bodyData: Data?, error: Error) {
        let logLine = getLogLine(successfullyCompletedRequest: true, response: response, bodyData: bodyData)
        
        logger.error("\(logLine)")
    }
    
    private func getLogLine(successfullyCompletedRequest: Bool, response: HTTPClient.Response?, bodyData: Data?) -> String {
        var logElements: [String] = []
        let completionString = successfullyCompletedRequest ? "Successfully" : "Unsuccessfully"
        logElements.append("\(completionString) completed outgoing request.")
        
        if let code = response?.status.code {
            logElements.append("Returned status code: \(code)")
        }
        
        if let requestIds = response?.headers[xAmzRequestId], !requestIds.isEmpty {
            logElements.append("Returned \(xAmzRequestId) header '\(requestIds.joined(separator: ","))'")
        }
        
        if let id2s = response?.headers[xAmzId2], !id2s.isEmpty {
            logElements.append("Returned \(xAmzId2) header '\(id2s.joined(separator: ","))'")
        }
        
        if let bodyData = bodyData {
            logElements.append("Returned body: \(bodyData.debugString)")
        }
        
        return logElements.joined(separator: " ")
    }
}