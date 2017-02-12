//
//  JSONDecodeError.swift
//  GitHubSearchRepository
//
//  Created by Kensuke Hoshikawa on 2017/02/12.
//  Copyright © 2017年 star__hoshi. All rights reserved.
//

import Foundation

enum JSONDecodeError: Error {
    case invalidFormat(json: Any)
    case missingValue(key: String, actualValue: Any?)
}
