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
// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length line_length identifier_name type_name vertical_parameter_alignment type_body_length
// -- Generated Code; do not edit --
//
// AWSSimpleQueueClientGenerator.swift
// SimpleQueueClient
//

import Foundation
import SimpleQueueModel
import SmokeAWSCore
import SmokeHTTPClient
import SmokeAWSHttp
import NIO
import NIOHTTP1

private extension Swift.Error {
    func isRetriable() -> Bool {
        if let typedError = self as? SimpleQueueError {
            return typedError.isRetriable()
        } else {
            return true
        }
    }
}

/**
 AWS Client Generator for the SimpleQueue service.
 */
public struct AWSSimpleQueueClientGenerator {
    let httpClient: HTTPClient
    let listHttpClient: HTTPClient
    let awsRegion: AWSRegion
    let service: String
    let apiVersion: String
    let target: String?
    let retryConfiguration: HTTPClientRetryConfiguration
    let retryOnErrorProvider: (Swift.Error) -> Bool
    let credentialsProvider: CredentialsProvider

    let operationsReporting: SimpleQueueOperationsReporting
    
    public init(credentialsProvider: CredentialsProvider, awsRegion: AWSRegion,
                endpointHostName: String,
                endpointPort: Int = 443,
                service: String = "sqs",
                contentType: String = "application/octet-stream",
                apiVersion: String = "2012-11-05",
                connectionTimeoutSeconds: Int64 = 10,
                retryConfiguration: HTTPClientRetryConfiguration = .default,
                eventLoopProvider: HTTPClient.EventLoopProvider = .spawnNewThreads,
                reportingConfiguration: SmokeAWSClientReportingConfiguration<SimpleQueueModelOperations>
                    = SmokeAWSClientReportingConfiguration<SimpleQueueModelOperations>() ) {
        let clientDelegate = XMLAWSHttpClientDelegate<SimpleQueueError>()

        let clientDelegateForListHttpClient = XMLAWSHttpClientDelegate<SimpleQueueError>(
            outputMapDecodingStrategy: .collapseMapUsingTags(keyTag: "Key", valueTag: "Value"), 
            inputQueryMapDecodingStrategy: .separateQueryEntriesWith(keyTag: "Key", valueTag: "Value"))

        self.httpClient = HTTPClient(endpointHostName: endpointHostName,
                                     endpointPort: endpointPort,
                                     contentType: contentType,
                                     clientDelegate: clientDelegate,
                                     connectionTimeoutSeconds: connectionTimeoutSeconds,
                                     eventLoopProvider: eventLoopProvider)
        self.listHttpClient = HTTPClient(endpointHostName: endpointHostName,
                                          endpointPort: endpointPort,
                                          contentType: contentType,
                                          clientDelegate: clientDelegateForListHttpClient,
                                          connectionTimeoutSeconds: connectionTimeoutSeconds,
                                          eventLoopProvider: eventLoopProvider)
        self.awsRegion = awsRegion
        self.service = service
        self.target = nil
        self.credentialsProvider = credentialsProvider
        self.retryConfiguration = retryConfiguration
        self.retryOnErrorProvider = { error in error.isRetriable() }
        self.apiVersion = apiVersion
        self.operationsReporting = SimpleQueueOperationsReporting(clientName: "AWSSimpleQueueClient", reportingConfiguration: reportingConfiguration)
    }

    /**
     Gracefully shuts down this client. This function is idempotent and
     will handle being called multiple times.
     */
    public func close() {
        httpClient.close()
        listHttpClient.close()
    }

    /**
     Waits for the client to be closed. If close() is not called,
     this will block forever.
     */
    public func wait() {
        httpClient.wait()
        listHttpClient.wait()
    }
    
    public func with<NewInvocationReportingType: HTTPClientCoreInvocationReporting>(
            reporting: NewInvocationReportingType) -> AWSSimpleQueueClient<NewInvocationReportingType> {
        return AWSSimpleQueueClient<NewInvocationReportingType>(
            credentialsProvider: self.credentialsProvider,
            awsRegion: self.awsRegion,
            reporting: reporting,
            httpClient: self.httpClient,
            listHttpClient: self.listHttpClient,
            service: self.service,
            apiVersion: self.apiVersion,
            retryOnErrorProvider: self.retryOnErrorProvider,
            retryConfiguration: self.retryConfiguration,
            operationsReporting: self.operationsReporting)
    }
}
