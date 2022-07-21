//
//  EndPoint+Calls.swift
//  GS_Demo
//
//  Created by Nikunj Joshi on 20/07/22.
//
import Foundation

extension Endpoint {
    static func fetchAPOD(baseUrl: URL) -> Endpoint {
        return Endpoint(baseUrl: baseUrl, path: Path.apod, method: .get)
    }
}
