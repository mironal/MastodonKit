//
//  Clients.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 4/17/17.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import Foundation

extension MastodonRequests {
    /// `Clients` requests.
    public enum Clients {
        /// Registers an application.
        open class Register: RequestBase<ClientApplication> {
            /// - Parameters:
            ///   - appName: Name of your application.
            ///   - redirectURI: Where the user should be redirected after authorization (for no redirect, omit this parameter).
            ///   - scopes: Application's access scopes.
            ///   - website: URL to the homepage of your app.
            public init(clientName: String,
                        redirectURI: String = "urn:ietf:wg:oauth:2.0:oob",
                        scopes: [AccessScope],
                        website: String? = nil) {
                let parameters = [
                    Parameter(name: "client_name", value: clientName),
                    Parameter(name: "redirect_uris", value: redirectURI),
                    Parameter(name: "website", value: website),
                    Parameter(name: "scopes", value: scopes.map(toString).joined(separator: " "))
                ]
                super.init(path: "/api/v1/apps", method: .post(.parameters(parameters)))
            }
        }
    }
}
