//
//  Request.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 4/17/17.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import Foundation

public protocol RequestProtocol {
    associatedtype Model: Decodable
    var path: String { get }
    var method: HTTPMethod { get }
}

extension RequestProtocol {
    public var method: HTTPMethod { .get(.empty) }
}

open class RequestBase<Model: Decodable>: RequestProtocol {
    public let path: String
    public let method: HTTPMethod
    init(path: String, method: HTTPMethod = .get(.empty)) {
        self.path = path
        self.method = method
    }
}

public struct Request<Model: Codable>: RequestProtocol {
    public let path: String
    public let method: HTTPMethod

    public init(path: String, method: HTTPMethod = .get(.empty)) {
        self.path = path
        self.method = method
    }
}
