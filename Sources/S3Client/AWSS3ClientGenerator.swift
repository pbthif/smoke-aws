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
// AWSS3ClientGenerator.swift
// S3Client
//

import Foundation
import S3Model
import SmokeAWSCore
import SmokeHTTPClient
import SmokeAWSHttp
import NIO
import NIOHTTP1
import AsyncHTTPClient

private extension Swift.Error {
    func isRetriable() -> Bool {
        if let typedError = self as? S3Error {
            return typedError.isRetriable()
        } else {
            return true
        }
    }
}

/**
 AWS Client Generator for the S3 service.
 */
public struct AWSS3ClientGenerator {
    let httpClient: HTTPOperationsClient
    let dataHttpClient: HTTPOperationsClient
    let awsRegion: AWSRegion
    let service: String
    let target: String?
    let retryConfiguration: HTTPClientRetryConfiguration
    let retryOnErrorProvider: (Swift.Error) -> Bool
    let credentialsProvider: CredentialsProvider

    let operationsReporting: S3OperationsReporting
    
    public init(credentialsProvider: CredentialsProvider, awsRegion: AWSRegion? = nil,
                endpointHostName: String = "s3.amazonaws.com",
                endpointPort: Int = 443,
                service: String = "s3",
                contentType: String = "application/x-amz-rest-xml",
                target: String? = nil,
                connectionTimeoutSeconds: Int64 = 10,
                retryConfiguration: HTTPClientRetryConfiguration = .default,
                eventLoopProvider: HTTPClient.EventLoopGroupProvider = .createNew,
                reportingConfiguration: SmokeAWSClientReportingConfiguration<S3ModelOperations>
                    = SmokeAWSClientReportingConfiguration<S3ModelOperations>() ) {
        let clientDelegate = XMLAWSHttpClientDelegate<S3Error>()

        let clientDelegateForDataHttpClient = DataAWSHttpClientDelegate<S3Error>()

        self.httpClient = HTTPOperationsClient(endpointHostName: endpointHostName,
                                               endpointPort: endpointPort,
                                               contentType: contentType,
                                               clientDelegate: clientDelegate,
                                               connectionTimeoutSeconds: connectionTimeoutSeconds,
                                               eventLoopProvider: eventLoopProvider)
        self.dataHttpClient = HTTPOperationsClient(endpointHostName: endpointHostName,
                                                    endpointPort: endpointPort,
                                                    contentType: contentType,
                                                    clientDelegate: clientDelegateForDataHttpClient,
                                                    connectionTimeoutSeconds: connectionTimeoutSeconds,
                                                    eventLoopProvider: eventLoopProvider)
        self.awsRegion = awsRegion ?? .us_east_1
        self.service = service
        self.target = target
        self.credentialsProvider = credentialsProvider
        self.retryConfiguration = retryConfiguration
        self.retryOnErrorProvider = { error in error.isRetriable() }
        self.operationsReporting = S3OperationsReporting(clientName: "AWSS3Client", reportingConfiguration: reportingConfiguration)
    }

    /**
     Gracefully shuts down this client. This function is idempotent and
     will handle being called multiple times.
     */
    public func close() throws {
        try httpClient.close()
        try dataHttpClient.close()
    }
    
    public func with<NewInvocationReportingType: HTTPClientCoreInvocationReporting>(
            reporting: NewInvocationReportingType) -> AWSS3Client<NewInvocationReportingType> {
        return AWSS3Client<NewInvocationReportingType>(
            credentialsProvider: self.credentialsProvider,
            awsRegion: self.awsRegion,
            reporting: reporting,
            httpClient: self.httpClient,
            dataHttpClient: self.dataHttpClient,
            service: self.service,
            target: self.target,
            retryOnErrorProvider: self.retryOnErrorProvider,
            retryConfiguration: self.retryConfiguration,
            operationsReporting: self.operationsReporting)
    }
}