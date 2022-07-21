//
//  PictureDetailsModel.swift
//  GS_Demo
//
//  Created by Nikunj Joshi on 20/07/22.
//

import Foundation

// MARK: - PictureDetails

struct PictureDetails: Codable {
    let date, explanation: String
    let hdurl: String
    let mediaType, serviceVersion, title: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case date, explanation, hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title, url
    }
}
