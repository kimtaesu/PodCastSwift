//
//  ResourcesLoader.swift
//  Flick
//
//  Created by tskim on 11/04/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import Foundation

class ResourcesLoader {
    static func loadJson<T: Decodable>(_ resource: String) -> T {
        let testBundle = Bundle(for: self)
        if let path = testBundle.path(forResource: resource, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                
            }
        }
        fatalError("can't decode \(T.self)")
    }
    static func readData(_ fileName: String, type: String) -> Data {
        let testBundle = Bundle(for: self)
        if let path = testBundle.path(forResource: fileName, ofType: type) {
            do {
                return try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            } catch {
                
            }
        }
        fatalError("can't read data")
    }
}
