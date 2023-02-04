//
//  ListsTests.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 1/2/18.
//  Copyright © 2018 MastodonKit. All rights reserved.
//

import XCTest
@testable import MastodonKit

class ListsTests: XCTestCase {
    func testAll() {
        let request = MastodonRequests.Lists.All()

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/lists")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.httpBody)
        XCTAssertNil(request.method.queryItems)
    }

    func testAccountsInList() {
        let request = MastodonRequests.Lists.Accounts(id: "42")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/lists/42/accounts")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.httpBody)
        XCTAssertNil(request.method.queryItems)
    }

    func testGet() {
        let request = MastodonRequests.Lists.Get(id: "42")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/lists/42")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.httpBody)
        XCTAssertNil(request.method.queryItems)
    }

    func testCreate() {
        let request = MastodonRequests.Lists.Create(title: "awesome list")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/lists")

        // Method
        XCTAssertEqual(request.method.name, "POST")
        XCTAssertNil(request.method.queryItems)
        XCTAssertNotNil(request.method.httpBody)

        let payload = String(data: request.method.httpBody!, encoding: .utf8)!
        XCTAssertEqual(payload.components(separatedBy: "&").count, 1)
        XCTAssertTrue(payload.contains("title=awesome%20list"))
    }

    func testUpdate() {
        let request = MastodonRequests.Lists.Update(id: "42", title: "awesome title")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/lists/42")

        // Method
        XCTAssertEqual(request.method.name, "PUT")
        XCTAssertNil(request.method.queryItems)
        XCTAssertNotNil(request.method.httpBody)

        let payload = String(data: request.method.httpBody!, encoding: .utf8)!
        XCTAssertEqual(payload.components(separatedBy: "&").count, 1)
        XCTAssertTrue(payload.contains("title=awesome%20title"))
    }

    func testDelete() {
        let request = MastodonRequests.Lists.Delete(id: "42")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/lists/42")

        // Method
        XCTAssertEqual(request.method.name, "DELETE")
        XCTAssertNil(request.method.queryItems)
        XCTAssertNil(request.method.httpBody)
    }

    func testAdd() {
        let request = MastodonRequests.Lists.Add(accountIDs: ["1", "2", "3"], toList: "42")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/lists/42/accounts")

        // Method
        XCTAssertEqual(request.method.name, "POST")
        XCTAssertNil(request.method.queryItems)
        XCTAssertNotNil(request.method.httpBody)

        let payload = String(data: request.method.httpBody!, encoding: .utf8)!
        XCTAssertEqual(payload.components(separatedBy: "&").count, 3)
        XCTAssertTrue(payload.contains("account_ids[]=1"))
        XCTAssertTrue(payload.contains("account_ids[]=2"))
        XCTAssertTrue(payload.contains("account_ids[]=3"))
    }

    func testRemove() {
        let request = MastodonRequests.Lists.Remove(accountIDs: ["1", "2", "3"], fromList: "42")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/lists/42/accounts")

        // Method
        XCTAssertEqual(request.method.name, "DELETE")
        XCTAssertNil(request.method.queryItems)
        XCTAssertNotNil(request.method.httpBody)

        let payload = String(data: request.method.httpBody!, encoding: .utf8)!
        XCTAssertEqual(payload.components(separatedBy: "&").count, 3)
        XCTAssertTrue(payload.contains("account_ids[]=1"))
        XCTAssertTrue(payload.contains("account_ids[]=2"))
        XCTAssertTrue(payload.contains("account_ids[]=3"))
    }
}
