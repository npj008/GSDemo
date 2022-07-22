//
//  GSApiServices.swift
//  GS_Demo
//
//  Created by Nikunj Joshi on 21/07/22.
//

import Foundation

// MARK: - GSAPIServiceError

public enum GSAPIServiceError: Error {

    case network(_: NetworkingError)
    
    public var localizedDescription: String {
        switch self {
        case .network(let error):
            return error.localizedDescription
        }
    }

}

// MARK: - GSAPIServiceResult

public enum GSAPIServiceResult<T> {
    case success(_: T)
    case failure(_: GSAPIServiceError)
}

// MARK: - APIService

struct APIService {
    static let baseUrl = URL(string: NetworkingConstants.baseURL)!
    static var shared = GSAPIServices.init(baseUrl: baseUrl)
}

protocol GSAPIServiceEntity {
    func fetchAPODDetails(date: Date, completion: @escaping (_: GSAPIServiceResult<PictureDetails>) -> Void)
}

// MARK: - GSAPIServices

public struct GSAPIServices: GSAPIServiceEntity {

    let baseUrl: URL
    
    // MARK: - Initialization

    public init(baseUrl: URL) {
        self.baseUrl = baseUrl
    }

    /**
        Fetch APOD for the given date:
        
        - Parameter date: Date object for which APOD needs to be fetched
        - Parameter @escaping completion: Completion handler returning ServiceResult with PictureDetails
    */
    func fetchAPODDetails(date: Date, completion: @escaping (_: GSAPIServiceResult<PictureDetails>) -> Void) {
        let endpoint = Endpoint.fetchAPOD(baseUrl: baseUrl)
        let request = endpoint.createRequest(query: [
            "api_key": NetworkingConstants.apiKey,
            "date": "2018-07-21"])
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
