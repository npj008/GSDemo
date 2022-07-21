//
//  Networking.swift
//  GS_Demo
//
//  Created by Nikunj Joshi on 21/07/22.
//

import Foundation

struct Empty: Codable {}

public enum NetworkingQueueType {
    case serial
    case concurrent
}

let serialNetworkingQueue = DispatchQueue(label: "gsDemotask.networking.requests.serial.queue")
let concurrentNetworkingQueue = DispatchQueue(label: "gsDemotask.networking.requests.concurrent.queue", qos: .background, attributes: .concurrent)

public class Networking<T: Codable>: NSObject {

    let configuration: URLSessionConfiguration?

    lazy var session: URLSession = {
        if let config = self.configuration {
            return URLSession(configuration: config)
        }
        return URLSession.shared
    }()

    var encodableBody: Encodable?
    var query: [String: String]?
    var fake: String?

    lazy var decoder: JSONDecoder = {
        let d = JSONDecoder()
        d.dateDecodingStrategy = .millisecondsSince1970
        return d
    }()

    public init(configuration: URLSessionConfiguration? = nil) {
        self.configuration = configuration
    }

    public func sendRequest(_ request: URLRequest, queueType: NetworkingQueueType = .concurrent, completion: @escaping (NetworkingResult<T>) -> Void) {

        func performRequest(completion: @escaping (NetworkingResult<T>) -> Void) {
            self.networkProcess(request: request) { result in
                switch result {
                case .success(let request):
                    self.session.dataTask(with: request) { data, response, error in
                        self.logNetworkRequest(request: request, error: error, data: data, response: response)
                        guard let httpResponse = response as? HTTPURLResponse else {
                            completion(.failure(.dataReturnedNil(nil)))
                            return
                        }
                        if let error = NetworkingError.error(forStatusCode: httpResponse.statusCode) {
                            if error == .unauthorized {
                                NotificationCenter.default.post(name: .networkingUnauthenticatedErrorNotification, object: nil)
                            }
                            completion(.failure(error))
                            return
                        }
                        let result: NetworkingResult<T> = self.decodeResponse(data: data, response: response, error: error)
                        completion(result)
                    }.resume()
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }

        switch queueType {
        case .concurrent:
            concurrentNetworkingQueue.async {
                performRequest(completion: completion)
            }
        case .serial:
            serialNetworkingQueue.async {
                performRequest(completion: completion)
            }
        }
    }

    private func decodeResponse<T: Codable>(data responseData: Data?, response: URLResponse?, error: Error?) -> NetworkingResult<T> {
        if T.self == Empty.self {
            return .success(Empty() as! T)
        }
        guard let data = responseData else {
            return .failure(.dataReturnedNil(error?.localizedDescription))
        }
        do {
            let object = try decoder.decode(T.self, from: data)
            return .success(object)
        } catch let error {
            return .failure(.jsonParsing(error.localizedDescription))
        }
    }

    private func logNetworkRequest(request: URLRequest, error: Error?, data: Data?, response: URLResponse?) {
        let urlLine = "\(request.httpMethod ?? "URL"): \(response?.url ?? URL(string: "/")!)"
        var headerLine = "Headers: "
        if let headers = request.allHTTPHeaderFields, let headerJson = try? JSONSerialization.data(withJSONObject: headers, options: .prettyPrinted), let headersString = String(data: headerJson, encoding: .utf8) {
            headerLine.append("\(headersString)\n")
        }

        var bodyLine = "Body: "
        if let body = request.httpBody, let bodyString = String(data: body, encoding: .utf8) {
            bodyLine.append("\(bodyString)\n\n\n")
        }

        var jsonResponseLine = "Response:\n\n"
        if let response = response as? HTTPURLResponse {
            jsonResponseLine.append("Status Code: \(response.statusCode)\n\n")
        }
        if let data = data, let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves),
            let prettyData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
            let json = String(data: prettyData, encoding: .utf8) {
            jsonResponseLine.append(json)
        }

        print("\(error.debugDescription)")

        print("""

        ---------- ~ ----------
           Networking Request
        ---------- ~ ----------
        \(urlLine)

        \(headerLine)

        \(bodyLine)

        \(jsonResponseLine)

        ---------- ~ ----------
        """)

    }

    /// Provides interface to check if the internet connection is available and access token is valid before making an request.
    /// - Parameters:
    ///   - request: the request to be processed.
    ///   - completion: returns `URLRequest` on success else `NetworkingError.noInternetConnection` on failure.
    private func networkProcess(request: URLRequest, completion: (NetworkingResult<URLRequest>) -> Void) {
        guard let reachability = try? Reachability() else {
          //  log.error("❌ Error: unable to create reachability instance.")
            fatalError("unable to create reachability instance.")
        }
        switch reachability.connection {
        case .none, .unavailable:
            completion(.failure(.noInternetConnection))
        case .wifi, .cellular:
            completion(.success(request))
        }
    }
}
