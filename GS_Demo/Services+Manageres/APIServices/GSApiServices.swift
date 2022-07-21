//
//  GSApiServices.swift
//  GS_Demo
//
//  Created by Nikunj Joshi on 21/07/22.
//

import Foundation

public enum GSAPIServiceError: Error {

    case network(_: NetworkingError)
    
    public var localizedDescription: String {
        switch self {
        case .network(let error):
            return error.localizedDescription
        }
    }

}

public enum GSAPIServiceResult<T> {
    case success(_: T)
    case failure(_: GSAPIServiceError)
}

struct APIService {
    static let baseUrl = URL(string: NetworkingConstants.baseURL)!
    static var shared = GSAPIServices.init(baseUrl: baseUrl)
}

public struct GSAPIServices {

    let baseUrl: URL

    public init(baseUrl: URL) {
        self.baseUrl = baseUrl
    }

    func fetchAPODDetails(date: String, completion: @escaping (_: GSAPIServiceResult<PictureDetails>) -> Void) {
        let endpoint = Endpoint.fetchAPOD(baseUrl: baseUrl)
        let request = endpoint.createRequest(query: [
            "api_key": NetworkingConstants.apiKey,
            "date": "2021-07-21"])
        let networking = Networking<PictureDetails>()
        networking.sendRequest(request) { (result) in
            switch result {
            case .success(let response):
                completion(.success(response))
                break
            case .failure(let error):
                completion(.failure(.network(error)))
                break
            }
        }
    }
}
