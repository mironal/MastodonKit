//
//  LoginTests.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 4/22/17.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import XCTest
@testable import MastodonKit

class LoginTests: XCTestCase {
    func testSilentLogin() {
        let request = Requests.Login.Silent(clientID: "client id", clientSecret: "client secret", scopes: [.read, .write], username: "foo", password: "123")

        // Endpoint
        XCTAssertEqual(request.path, "/oauth/token")

        // Method
        XCTAssertEqual(request.method.name, "POST")
        XCTAssertNil(request.method.queryItems)

        let payload = String(data: request.method.httpBody!, encoding: .utf8)!
        XCTAssertEqual(payload.components(separatedBy: "&").count, 6)
        XCTAssertTrue(payload.contains("client_id=client%20id"))
        XCTAssertTrue(payload.contains("client_secret=client%20secret"))
        XCTAssertTrue(payload.contains("scope=read%20write"))
        XCTAssertTrue(payload.contains("grant_type=password"))
        XCTAssertTrue(payload.contains("username=foo"))
        XCTAssertTrue(payload.contains("password=123"))
    }

    func testOAuthLogin() {
        let request = Requests.Login.OAuth(clientID: "client id", clientSecret: "client secret", scopes: [.read, .write], redirectURI: "foo://oauth", code: "123")

        // Endpoint
        XCTAssertEqual(request.path, "/oauth/token")

        // Method
        XCTAssertEqual(request.method.name, "POST")
        XCTAssertNil(request.method.queryItems)

        let payload = String(data: request.method.httpBody!, encoding: .utf8)!
        XCTAssertEqual(payload.components(separatedBy: "&").count, 6)
        XCTAssertTrue(payload.contains("client_id=client%20id"))
        XCTAssertTrue(payload.contains("client_secret=client%20secret"))
        XCTAssertTrue(payload.contains("scope=read%20write"))
        XCTAssertTrue(payload.contains("grant_type=authorization_code"))
        XCTAssertTrue(payload.contains("redirect_uri=foo%3A//oauth"))
        XCTAssertTrue(payload.contains("code=123"))
    }

    func testOAuthLogout() throws {

        let request = Requests.Login.RevokeOauth(clientID: "client id",
                                                 clientSecret: "client secret",
                                                 token: "the secret code is yellow")

        // Endpoint
        XCTAssertEqual(request.path, "/oauth/revoke")

        // Method
        XCTAssertEqual(request.method.name, "POST")
        XCTAssertNil(request.method.queryItems)

        let payload = String(data: request.method.httpBody!, encoding: .utf8)!
        XCTAssertEqual(payload.components(separatedBy: "&").count, 3)
        XCTAssertTrue(payload.contains("client_id=client%20id"))
        XCTAssertTrue(payload.contains("client_secret=client%20secret"))
        XCTAssertTrue(payload.contains("token=the%20secret%20code%20is%20yellow"))
    }
}
