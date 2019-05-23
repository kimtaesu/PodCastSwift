//
//  PodCastApi.swift
//  PodCastSwift
//
//  Created by tskim on 20/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation
import Moya
import Result

enum PodCastApi {
    case search(String)
}

extension PodCastApi: TargetType {
    var baseURL: URL { return URL(string: "https://itunes.apple.com/")! }
    
    var path: String {
        switch self {
        case .search:
            return "search"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .search:
            return .get
        }
    }
    
    var parameterEncoding: Moya.ParameterEncoding {
        switch self {
        case .search:
            return URLEncoding.default
        }
    }
    
    var task: Task {
        switch self {
        case .search(let keyword):
            return .requestParameters(parameters: ["term": keyword, "media": "podcast"], encoding: parameterEncoding)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            return ["Content-Type": "application/json;charset=UTF-8"]
        }
    }
}

extension PodCastApi {
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
}
