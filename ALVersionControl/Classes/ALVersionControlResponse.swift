//
//  ALVersionControlResponse.swift
//  Applogist
//
//  Created by Soner Guler on 10.12.2019.
//  Copyright © 2019 Applogist. All rights reserved.
//

import Foundation

public enum ALVersionControlStatus: Int, Codable {
    
    /// All good. App is up to date
    case upToDate = 0
    /// Optional update available
    case optional = 1
    /// Force update available
    case force = 2
}

public struct ALVersionControlResponse: Decodable {
    
    /// The info message which inform to user there is a new update.
    let message: String?
    /// The status of new update.
    let status: ALVersionControlStatus?
    /// The market url which lead the user to update the app
    let url: URL?
    
    public init(message: String?, status: ALVersionControlStatus?, url: URL?) {
        self.message = message
        self.status = status
        self.url = url
    }
}
