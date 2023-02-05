//
//  Reports.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 4/9/17.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import Foundation

extension Requests {
    /// `Reports` requests.
    public enum Reports {
        /// Fetches a user's reports.
        open class All: RequestBase<[Report]> {
            public init() {
                super.init(path: "/api/v1/reports")
            }
        }

        /// Reports a user.
        open class Create: RequestBase<Report> {
            /// - Parameters:
            ///   - accountID: The ID of the account to report.
            ///   - statusIDs: The IDs of statuses to report.
            ///   - reason: A comment to associate with the report.
            public init(accountID: String, statusIDs: [String], reason: String) {
                let parameters = [
                    Parameter(name: "account_id", value: accountID),
                    Parameter(name: "comment", value: reason)
                ] + statusIDs.map(toArrayOfParameters(withName: "status_ids"))
                super.init(path: "/api/v1/reports", method: .post(.parameters(parameters)))
            }
        }
    }
}
