//
//  ALVersionControlRequest.swift
//  Applogist
//
//  Created by Soner Guler on 10.12.2019.
//  Copyright © 2019 Applogist. All rights reserved.
//

import Foundation

public struct ALVersionControlRequest: Encodable {
    
    /// OS Type 1:iOS - 2:Android
    let os: Int
    /// App bundle version (e.g. 1.0.2)
    let version: String

    public init() {
        self.os = 1
        self.version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
}
