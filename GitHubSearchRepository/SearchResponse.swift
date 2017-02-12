//
//  SearchResponse.swift
//  GitHubSearchRepository
//
//  Created by Kensuke Hoshikawa on 2017/02/12.
//  Copyright © 2017年 star__hoshi. All rights reserved.
//

import Foundation

struct SearchResponse<Item: JSONDecodable>: JSONDecodable {
    let totlaCount: Int
    let items: [Item]

    init(json: Any) throws {
        guard let dictionary = json as? [String: Any] else {
            throw JSONDecodeError.invalidFormat(json: json)
        }

        guard let totalCount = dictionary["total_count"] as? Int else {
            throw JSONDecodeError.missingValue(key: "total_count", actualValue: dictionary["total_count"])
        }

        guard let itemObject = dictionary["items"] as? [Any] else {
            throw JSONDecodeError.missingValue(key: "items", actualValue: dictionary["items"])
        }

        let items = try itemObject.map {
            return try Item(json: $0)
        }

        self.totlaCount = totalCount
        self.items = items
    }
}
