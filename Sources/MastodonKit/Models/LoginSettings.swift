//
//  LoginSettings.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 4/18/17.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import Foundation

public struct LoginSettings: Codable, Hashable {
    /// The user's access token.
    public let accessToken: String
    /// Access token type.
    public let accessTokenType: String
    /// Date when the access token was retrieved.
    public let createdAt: TimeInterval
    /// Access scope.
    private let scope: String
    /// Access scopes.
    public var scopes: [AccessScope] {
        return scope
            .components(separatedBy: .whitespaces)
            .compactMap(toAccessScope)
    }

    public init(accessToken: String, accessTokenType: String, createdAt: TimeInterval, scope: String) {
        self.accessToken = accessToken
        self.accessTokenType = accessTokenType
        self.createdAt = createdAt
        self.scope = scope
    }

    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case accessTokenType = "token_type"
        case scope
        case createdAt = "created_at"
    }
}
