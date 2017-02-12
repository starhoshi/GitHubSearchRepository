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

    func buildURLRequest() -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)

        switch method {
        case .get:
            let dictionary = parameters as? [String: Any]
            let queryItems = dictionary?.map { key, value in
                return URLQueryItem (
                    name: key,
                    value: String(describing: value)
                )
            }
            components?.queryItems = queryItems

        default:
            fatalError("unsuppoerted method \(method)")
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.url = components?.url
        urlRequest.httpMethod = method.rawValue

        return urlRequest
    }

    func response(from data: Data, urlResponse: URLResponse) throws -> Response {
        let json = try JSONSerialization.jsonObject(with: data, options: [])
        if case (200..<300)? = (urlResponse as? HTTPURLResponse)?.statusCode {
            return try Response(json: json)
        } else {
            throw try GitHubAPIError(json: json)
        }
    }
}
