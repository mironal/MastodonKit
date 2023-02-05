//
//  Login.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 4/18/17.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import Foundation

extension Requests {
    /// `Login` requests.
    public enum Login {
        /// Performs a silent login.
        open class Silent: RequestBase<LoginSettings> {
            /// - Parameters:
            ///   - clientID: The client ID.
            ///   - clientSecret: The client secret.
            ///   - scopes: The access scopes.
            ///   - username: The user's username or e-mail address.
            ///   - password: The user's password.
            public init(clientID: String,
                        clientSecret: String,
                        scopes: [AccessScope],
                        username: String,
                        password: String) {
                let parameters = [
                    Parameter(name: "client_id", value: clientID),
                    Parameter(name: "client_secret", value: clientSecret),
                    Parameter(name: "scope", value: scopes.map(toString).joined(separator: " ")),
                    Parameter(name: "grant_type", value: "password"),
                    Parameter(name: "username", value: username),
                    Parameter(name: "password", value: password)
                ]
                super.init(path: "/oauth/token", method: .post(.parameters(parameters)))
            }
        }

        /// Completes an OAuth login.
        open class OAuth: RequestBase<LoginSettings> {
            /// - Parameters:
            ///   - clientID: The client ID.
            ///   - clientSecret: The client secret.
            ///   - scopes: The access scopes.
            ///   - redirectURI: The client redirectURI.
            ///   - code: The authorization code.
            public init(clientID: String,
                        clientSecret: String,
                        scopes: [AccessScope],
                        redirectURI: String,
                        code: String) {
                let parameters = [
                    Parameter(name: "client_id", value: clientID),
                    Parameter(name: "client_secret", value: clientSecret),
                    Parameter(name: "scope", value: scopes.map(toString).joined(separator: " ")),
                    Parameter(name: "grant_type", value: "authorization_code"),
                    Parameter(name: "redirect_uri", value: redirectURI),
                    Parameter(name: "code", value: code)
                ]
                super.init(path: "/oauth/token", method: .post(.parameters(parameters)))
            }
        }
    }
}
