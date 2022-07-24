//
//  EndPoint.swift
//  GS_Demo
//
//  Created by Nikunj Joshi on 20/07/22.
//

import Foundation

// MARK: - Endpoint

struct Endpoint {
        
    static let encoder = JSONEncoder()
    
    let baseUrl: URL
    let path: String
    let method: Method
    private var token: String?
    private var subscriptionKey: String?
    
    init(baseUrl: URL, path: String, method: Method) {
        self.baseUrl = baseUrl
        self.path = path
        self.method = method
    }
    
    func createRequest<T: Encodable>(body: T?) -> URLRequest {
        var request = URLRequest(url: baseUrl.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        
        // Add body if needed
        if let info = body, let bodyData = try? Endpoint.encoder.encode(info) {
            request.httpBody = bodyData
        }
        setHeaders(request: &request)
        return request
    }

    func createRequest() -> URLRequest {
        var request = URLRequest(url: baseUrl.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        setHeaders(request: &request)
        return request
    }
    
    func createRequest(query: [String: String]?) -> URLRequest {
        var urlComps = URLComponents(url: baseUrl.appendingPathComponent(path), resolvingAgainstBaseURL: false)
        if let query = query {
            urlComps?.queryItems = query.map {URLQueryItem(name: $0.key, value: $0.value)}
        }
        let url = urlComps?.url
        var request = URLRequest(url: url ?? baseUrl.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        setHeaders(request: &request)
        return request
    }
    
    mutating func setAuthorizationHeader(token: String) {
        self.token = token
    }
    
    private func setHeaders(request: inout URLRequest) {
        var headers: [String: String] = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        if let token = token {
            headers["Authorization"] = "Bearer \(token)"
        }
        request.allHTTPHeaderFields = headers
    }
}
