//
//  NetworkingConstants.swift
//  GS_Demo
//
//  Created by Nikunj Joshi on 21/07/22.
//

import Foundation

public enum NetworkingResult<T> {
    case success(T)
    case failure(NetworkingError)
}

/// Representation of the type of networking error.
public enum NetworkingError: Error {
    /// There was no data retruned
    case dataReturnedNil(String?)
    /// Remote server error
    case serverError
    /// Provided auth was not valid
    case unauthorized
    /// Internet is not online
    case noInternetConnection
    /// Status code not expected
    case invalidStatusCode(Int)
    /// Could not parse json data
    case jsonParsing(String)
    /// Another error occurred
    case custom(String)
    /// Access is not allowed
    case forbidden
    /// API Limit reached
    case apiLimitReached
    
    /// Provides interface to check and return `NetworkError` type as per status code.
    /// - Parameter code: the http status code recieved from server.
    static func error(forStatusCode code: Int) -> NetworkingError? {
        switch code {
        case 200...299:
            return nil
        case 401:
            return .unauthorized
        case 403:
            return .forbidden
        case 429:
            return .apiLimitReached
        case 500...599:
            return .serverError
        case -1009:
            return .noInternetConnection
        default:
            return .invalidStatusCode(code)
        }
    }
}

extension NetworkingError: LocalizedError {
    /// :nodoc:
    public var localizedDescription: String? {
        switch self {
        case .custom(let message):
            return message
        case .dataReturnedNil(let message):
            return message ?? Localized.dataReturnedNil
        case .serverError:
            return  Localized.serverError
        case .unauthorized:
            return Localized.unauthorized
        case .noInternetConnection:
            return Localized.noInternetConnectionMessage
        case .invalidStatusCode(let code):
            return "Invalid Status Code : \(code)"
        case .forbidden:
            return "403 Forbidden."
        case .jsonParsing(let message):
            return "Unable to parse JSON response: \(message)"
        case .apiLimitReached:
            return "API Limit Reached"
        }
    }
}

extension NetworkingError: Equatable {
    /// Check if 2 `NetworkingError`s are the same
    public static func == (lhs: NetworkingError, rhs: NetworkingError) -> Bool {
        switch (lhs, rhs) {
        case (.custom(let lhsMessage), .custom(let rhsMessage)):
            return lhsMessage == rhsMessage
        case (.dataReturnedNil, .dataReturnedNil):
            return true
        case (.serverError, .serverError):
            return true
        case (.unauthorized, .unauthorized):
            return true
        case (.noInternetConnection, .noInternetConnection):
            return true
        case (.invalidStatusCode(let lhsCode), .invalidStatusCode(let rhsCode)):
            return lhsCode == rhsCode
        case (.forbidden, .forbidden):
            return true
        default:
            return false
        }
        
    }
}

struct Localized {

    static var dataReturnedNil = NSLocalizedString("dataReturnedNil", comment: "Either the response code or the header was missing in the response.")
    static var noInternetConnectionMessage = NSLocalizedString("noInternetConnectionMessage", comment: "There is no internet connection. Something wrong with the proxy server or the address is incorrect.")
    static var serverError = NSLocalizedString("serverError", comment: "An unexpected condition was encountered and no more specific message is suitable.")
    static var unauthorized = NSLocalizedString("unauthorized", comment: "The user does not have valid authentication credentials for the target resource.")
}

/// The connections state for the client
public enum NetworkingState {
    /// code -1009
    case noNetworkConnection
    /// 200 status codes
    case connected
    /// 401 status code
    case unauthorized
    /// 500 status codes
    case serverError
}

extension Notification.Name {
    static let networkingUnauthenticatedErrorNotification = Notification.Name("gs-NetworkingUnauthenticatedErrorNotification")
}

