//
//  GitHubClient.swift
//  GitHubSearchRepository
//
//  Created by Kensuke Hoshikawa on 2017/02/12.
//  Copyright © 2017年 star__hoshi. All rights reserved.
//

import Foundation

class GitHubClient {
    private let session: URLSession = {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        return session
    }()

    func send<Request: GitHubRequest> (
        request: Request,
        compiletion: @escaping (Result<Request.Response, GitHubClientError>) -> Void) {
            let urlRequest = request.buildURLRequest()
            let task = session.dataTask(with: urlRequest) {
                data, response, error in

                switch (data, response, error) {
                case (_, _, let error?):
                    compiletion(Result(error: .connectionError(error)))
                case (let data?, let response?, _):
                    do {
                        let response = try request.response(from: data, urlResponse: response)
                        compiletion(Result(value: response))
                    } catch let error as GitHubAPIError {
                        compiletion(Result(error: .apiError(error)))
                    } catch {
                        compiletion(Result(error: .responseParseError(error)))
                    }
                default:
                    fatalError("invalid response combination\(data), \(response), \(error)")
                }
            }

            task.resume()
    }
}
