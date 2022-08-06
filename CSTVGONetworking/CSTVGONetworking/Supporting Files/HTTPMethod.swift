//
//  HTTPMethod.swift
//  CSGOTVSDK
//
//  Created by Luzenildo Junior on 05/08/22.
//

import Foundation

struct HTTPMethod: RawRepresentable, Equatable, Hashable {
    /// `DELETE` method.
    public static let delete = HTTPMethod(rawValue: "DELETE")
    /// `GET` method.
    public static let get = HTTPMethod(rawValue: "GET")
    /// `PATCH` method.
    public static let patch = HTTPMethod(rawValue: "PATCH")
    /// `POST` method.
    public static let post = HTTPMethod(rawValue: "POST")

    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}
