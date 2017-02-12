//
//  GitHubAPI.swift
//  GitHubSearchRepository
//
//  Created by Kensuke Hoshikawa on 2017/02/12.
//  Copyright © 2017年 star__hoshi. All rights reserved.
//

import Foundation
final class GitHubAPI {
    struct SearchRepositories: GitHubRequest {
        let keyword: String

        typealias Response = SearchResponse<Repository>

//        typealias Response = SearchResponse<Repository>

        var method: HTTPMethods {
            return .get
        }

        var path: String {
            return "/search/repositories"
        }

        var parameters: Any? {
            return ["q": keyword]
        }
    }

    struct SearchUsers: GitHubRequest {
        let keyword: String

        typealias Response = SearchResponse<User>

        var method: HTTPMethods {
            return .get
        }

        var path: String {
            return "search/users"
        }

        var parameters: Any? {
            return ["q": keyword]
        }
    }
}
