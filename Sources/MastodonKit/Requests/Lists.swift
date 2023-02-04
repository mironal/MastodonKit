//
//  Lists.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 1/2/18.
//  Copyright © 2018 MastodonKit. All rights reserved.
//

import Foundation

extension MastodonRequests {
    /// `Lists` requests.
    public enum Lists {
        /// Retrieves lists.
        open class All: RequestBase<[List]> {
            /// - Returns: Request for `[List]`.
            public init()  {
                super.init(path: "/api/v1/lists")
            }
        }

        /// Retrieves accounts in a list.
        open class Accounts: RequestBase<[Account]> {
            /// - Parameter id: The list ID.
            public init(id: String) {
                super.init(path: "/api/v1/lists/\(id)/accounts")
            }
        }

        /// Retrieves a list.
        open class Get: RequestBase<List> {
            /// - Parameter id: The list ID.
            public init(id: String) {
                super.init(path: "/api/v1/lists/\(id)")
            }
        }

        /// Creates a list.
        open class Create: RequestBase<List> {
            /// - Parameter title: The title of the list.
            public init(title: String) {
                let parameter = [Parameter(name: "title", value: title)]
                super.init(path: "/api/v1/lists", method: .post(.parameters(parameter)))
            }
        }

        /// Updates the list title.
        open class Update: RequestBase<List> {
            /// - Parameters:
            ///   - id: The list ID.
            ///   - title: The title of the list.
            public init(id: String, title: String) {
                let parameter = [Parameter(name: "title", value: title)]
                super.init(path: "/api/v1/lists/\(id)", method: .put(.parameters(parameter)))
            }
        }

        /// Deletes a list.
        open class Delete: RequestBase<Empty> {
            /// - Parameter id: The list ID.
            public init(id: String) {
                super.init(path: "/api/v1/lists/\(id)", method: .delete(.empty))
            }
        }

        /// Adds accounts to a list.
        open class Add: RequestBase<Empty> {
            /// - Parameters:
            ///   - accountIDs: The account IDs to be added to the list.
            ///   - id: The list ID>
            public init(accountIDs: [String], toList id: String) {
                let parameter = accountIDs.map(toArrayOfParameters(withName: "account_ids"))
                super.init(path: "/api/v1/lists/\(id)/accounts", method: .post(.parameters(parameter)))
            }
        }

        /// Removes accounts from a list.
        open class Remove: RequestBase<Empty> {
            /// - Parameters:
            ///   - accountIDs: The account IDs to be removed from the list.
            ///   - id: The list ID>
            public init(accountIDs: [String], fromList id: String) {
                let parameter = accountIDs.map(toArrayOfParameters(withName: "account_ids"))
                super.init(path: "/api/v1/lists/\(id)/accounts", method: .delete(.parameters(parameter)))
            }
        }
    }
}
