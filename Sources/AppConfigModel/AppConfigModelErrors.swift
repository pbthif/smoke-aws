// Copyright 2018-2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
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
// swiftlint:disable file_length line_length identifier_name type_name vertical_parameter_alignment
// swiftlint:disable type_body_length function_body_length generic_type_name cyclomatic_complexity
// -- Generated Code; do not edit --
//
// AppConfigModelErrors.swift
// AppConfigModel
//

import Foundation
import Logging

public typealias AppConfigErrorResult<SuccessPayload> = Result<SuccessPayload, AppConfigError>

public extension Swift.Error {
    func asUnrecognizedAppConfigError() -> AppConfigError {
        let errorType = String(describing: type(of: self))
        let errorDescription = String(describing: self)
        return .unrecognizedError(errorType, errorDescription)
    }
}

private let accessDeniedIdentity = "AccessDeniedException"
private let badRequestIdentity = "BadRequestException"
private let conflictIdentity = "ConflictException"
private let internalServerIdentity = "InternalServerException"
private let payloadTooLargeIdentity = "PayloadTooLargeException"
private let resourceNotFoundIdentity = "ResourceNotFoundException"
private let serviceQuotaExceededIdentity = "ServiceQuotaExceededException"

public struct AppConfigErrorPayload: Codable {
    public let type: String
    public let message: String

    enum CodingKeys: String, CodingKey {
        case type = "__type"
        case message = "Message"
    }
}

public enum AppConfigError: Swift.Error, Decodable {
    case accessDenied(AppConfigErrorPayload)
    case badRequest(BadRequestException)
    case conflict(ConflictException)
    case internalServer(InternalServerException)
    case payloadTooLarge(PayloadTooLargeException)
    case resourceNotFound(ResourceNotFoundException)
    case serviceQuotaExceeded(ServiceQuotaExceededException)
    case validationError(reason: String)
    case unrecognizedError(String, String?)

    enum CodingKeys: String, CodingKey {
        case type = "__type"
        case message = "Message"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        var errorReason = try values.decodeIfPresent(String.self, forKey: .type) ?? "Unspecified"
        let errorMessage = try values.decodeIfPresent(String.self, forKey: .message)
        
        if let index = errorReason.firstIndex(of: "#") {
            errorReason = String(errorReason[errorReason.index(index, offsetBy: 1)...])
        }

        switch errorReason {
        case accessDeniedIdentity:
            let errorPayload = try AppConfigErrorPayload(from: decoder)
            self = AppConfigError.accessDenied(errorPayload)
        case badRequestIdentity:
            let errorPayload = try BadRequestException(from: decoder)
            self = AppConfigError.badRequest(errorPayload)
        case conflictIdentity:
            let errorPayload = try ConflictException(from: decoder)
            self = AppConfigError.conflict(errorPayload)
        case internalServerIdentity:
            let errorPayload = try InternalServerException(from: decoder)
            self = AppConfigError.internalServer(errorPayload)
        case payloadTooLargeIdentity:
            let errorPayload = try PayloadTooLargeException(from: decoder)
            self = AppConfigError.payloadTooLarge(errorPayload)
        case resourceNotFoundIdentity:
            let errorPayload = try ResourceNotFoundException(from: decoder)
            self = AppConfigError.resourceNotFound(errorPayload)
        case serviceQuotaExceededIdentity:
            let errorPayload = try ServiceQuotaExceededException(from: decoder)
            self = AppConfigError.serviceQuotaExceeded(errorPayload)
        default:
            self = AppConfigError.unrecognizedError(errorReason, errorMessage)
        }
    }
    
}

