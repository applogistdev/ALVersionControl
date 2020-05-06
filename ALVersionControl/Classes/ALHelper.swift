//
//  ALVersionHelper.swift
//  ALVersionControl
//
//  Created by Soner Güler on 6.05.2020.
//

import Foundation

final class ALHelper {
    
    static func localizedText(key: String) -> String {
        let podBundle = Bundle(for: self)
        /// A given class within your Pod framework
        guard let url = podBundle.url(forResource: "ALVersionControl", withExtension: "bundle") else {
            return key
        }
        return NSLocalizedString(key, tableName: "Localization", bundle: Bundle(url: url)!, value: key, comment: key)
    }
}
