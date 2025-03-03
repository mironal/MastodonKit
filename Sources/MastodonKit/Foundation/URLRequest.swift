//
//  URLRequest.swift
//  MastodonKit
//
//  Created by Ornithologist Coder on 4/22/17.
//  Copyright © 2017 MastodonKit. All rights reserved.
//

import Foundation

extension URLRequest {
    init<Request: RequestProtocol>(url: URL, request: Request, accessToken: String?) {
        self.init(url: url, timeoutInterval: 30)

        httpMethod = request.method.name
        httpBody = request.method.httpBody

        setValue(accessToken.map { "Bearer \($0)" }, forHTTPHeaderField: "Authorization")
        setValue(request.method.contentType, forHTTPHeaderField: "Content-Type")
    }
}
