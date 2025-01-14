//
//  DomainBlocksTests.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 6/5/17.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import XCTest
@testable import MastodonKit

class DomainBlocksTests: XCTestCase {
    func testAll() {
        let request = Requests.DomainBlocks.All()

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/domain_blocks")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.httpBody)
        XCTAssertNil(request.method.queryItems)
    }

    func testAllWithRange() {
        let request = Requests.DomainBlocks.All(range: .max(id: "42", limit: nil))
        let expectedMaxID = URLQueryItem(name: "max_id", value: "42")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/domain_blocks")

        // Method
        XCTAssertEqual(request.method.name, "GET")
        XCTAssertNil(request.method.httpBody)
        XCTAssertEqual(request.method.queryItems?.count, 1)
        XCTAssertTrue(request.method.queryItems!.contains(expectedMaxID))
    }

    func testBlock() {
        let request = Requests.DomainBlocks.Block(domain: "foobar")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/domain_blocks")

        // Method
        XCTAssertEqual(request.method.name, "POST")
        XCTAssertNil(request.method.queryItems)
        XCTAssertNotNil(request.method.httpBody)

        let payload = String(data: request.method.httpBody!, encoding: .utf8)!
        XCTAssertEqual(payload.components(separatedBy: "&").count, 1)
        XCTAssertTrue(payload.contains("domain=foobar"))
    }

    func testUnlock() {
        let request = Requests.DomainBlocks.Unblock(domain: "foobar")

        // Endpoint
        XCTAssertEqual(request.path, "/api/v1/domain_blocks")

        // Method
        XCTAssertEqual(request.method.name, "DELETE")
        XCTAssertNil(request.method.queryItems)
        XCTAssertNotNil(request.method.httpBody)

        let payload = String(data: request.method.httpBody!, encoding: .utf8)!
        XCTAssertEqual(payload.components(separatedBy: "&").count, 1)
        XCTAssertTrue(payload.contains("domain=foobar"))
    }
}
