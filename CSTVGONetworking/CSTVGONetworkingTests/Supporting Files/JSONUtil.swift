//
//  JSONUtil.swift
//  CSGOTVNetworking
//
//  Created by Luzenildo Junior on 08/08/22.
//

import Foundation

final class JSONUtil { }

extension String {
    func decodeJSONString<T: Decodable>() -> T {
        guard let jsonData = self.data(using: .utf8) else {
            fatalError("Unable to convert json to data")
        }
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(T.self, from: jsonData)
            return decodedData
        } catch {
            fatalError("Unable to decode data")
        }
    }
    
    func decodeJSONFromFileName<T: Decodable>() -> T {
        guard let pathString = Bundle(for: JSONUtil.self).path(forResource: self, ofType: "json"),
              let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8),
              let jsonData = jsonString.data(using: .utf8) else {
            fatalError("Unable to find json and convert to data")
        }
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(T.self, from: jsonData)
            return decodedData
        } catch {
            fatalError("Unable to decode data")
        }
    }
    
    func getJsonStringFromFileName() -> String {
        guard let pathString = Bundle(for: JSONUtil.self).path(forResource: self, ofType: "json"),
              let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8) else {
            fatalError("Unable to find json")
        }
        return jsonString
    }
}
