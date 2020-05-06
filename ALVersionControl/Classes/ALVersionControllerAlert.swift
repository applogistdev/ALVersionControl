//
//  ALVersionControllerAlert.swift
//  Applogist
//
//  Created by Soner Guler on 10.12.2019.
//  Copyright © 2019 Applogist. All rights reserved.
//

import UIKit

final class ALVersionControllerAlert {

    let message: String
    let dismissable: Bool

    init(message: String, dismissable: Bool = false) {
        self.message = message
        self.dismissable = dismissable
    }

    func view(updateHandler: ((UIAlertAction) -> Void)?, cancelHandler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let cont = UIAlertController(title: nil, message: message, preferredStyle: .alert)

        let updateAction = UIAlertAction(title: ALHelper.localizedText(key: "text_update"), style: .default, handler: updateHandler)

        cont.addAction(updateAction)

        if dismissable {
            let cancelAction = UIAlertAction(title: ALHelper.localizedText(key: "text_cancel"), style: .default, handler: cancelHandler)
            cont.addAction(cancelAction)
        }
        return cont
    }
}
