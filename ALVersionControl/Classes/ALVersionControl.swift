//
//  ALVersionControl.swift
//  Applogist
//
//  Created by Soner Guler on 10.12.2019.
//  Copyright © 2019 Applogist. All rights reserved.
//

import UIKit

public protocol ALVersionControllerDelegate: class {
    
    /// Triggered when version control needs to get response of version control api
    /// - Parameters:
    ///   - controller: Instance of ALVersionController
    ///   - completion: Must call to handle api call response in order to version control works
    func versionControllerAPIHandler(controller: ALVersionControl, completion: @escaping ((ALVersionControlResponse?) -> Void))
}

final public class ALVersionControl {

    static public let shared = ALVersionControl()

    weak private var delegate: ALVersionControllerDelegate?

    private var optionalDisplayedBeforeKey = "ALOptionalDisplayedBefore"
    private var optionalDisplayedBefore: Bool {
        get {
            return UserDefaults.standard.bool(forKey: optionalDisplayedBeforeKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: optionalDisplayedBeforeKey)
        }
    }
    

    // MARK: - Public

    /// Setup version control and trigger the api call
    /// - Parameter delegate: Version Control Delegate
    public func setup(delegate: ALVersionControllerDelegate) {
        self.delegate = delegate
        callbackHandler()
    }
    
    /// Must be called in **applicationDidBecomeActive** block
    public func appDidBecomeActive() {
        callbackHandler()
    }

    
    // MARK: - Private

    private func callbackHandler() {
        delegate?.versionControllerAPIHandler(controller: self, completion: { [weak self] (response) -> Void in
            self?.handleVersionResponse(with: response)
        })
    }

    private func handleVersionResponse(with response: ALVersionControlResponse?) {
        guard let response = response else {
            return
        }

        switch response.status {
        case .upToDate:
            optionalDisplayedBefore = false
        case .optional:
            if optionalDisplayedBefore == false {
                displayPopup(message: response.message, url: response.url, optional: true)
                optionalDisplayedBefore = true
            }
        case .force:
            displayPopup(message: response.message, url: response.url, optional: false)
        case .none:
            break
        }
    }

    private func displayPopup(message: String?, url: URL?, optional: Bool) {
        let msg = message ?? ALHelper.localizedText(key: "text_new_update_message")
        let alertCont = ALVersionControllerAlert(message: msg, dismissable: optional).view(updateHandler: { (_) in
            if let url = url {
                self.navigateTo(url: url)
            }
        })
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.rootViewController?.present(alertCont, animated: false, completion: nil)
        }
    }

    private func navigateTo(url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}
