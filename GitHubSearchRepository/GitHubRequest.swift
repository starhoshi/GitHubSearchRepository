//
//  GitHubRequest.swift
//  GitHubSearchRepository
//
//  Created by Kensuke Hoshikawa on 2017/02/12.
//  Copyright © 2017年 star__hoshi. All rights reserved.
//

import Foundation

protocol GitHubRequest {
    associatedtype Response: JSONDecodable

    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethods { get }
    var parameters: Any? { get }
}

extension GitHubRequest {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
}
