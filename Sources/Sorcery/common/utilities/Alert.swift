//
//  Alert.swift
//  Core
//
//  Created by John Cumming on 8/31/18.
//  Copyright © 2018 Silicon Sorcery, Inc. All rights reserved.
//

// import UIKit

//enum Alert {
//
//    static func show(
//        title: String,
//        message: String,
//        accept: String? = nil,
//        from viewController: UIViewController? = nil,
//        completion: ((UIAlertAction) -> Void)? = nil
//    ) {
//        if let viewController: UIViewController =
//            viewController ??
//            UIApplication.shared.windows.first( where: { $0.isKeyWindow })?.rootViewController
//        {
//
//            let hasCancel = (accept != nil)
//            let accept: String = accept ?? "OK"
//
//            let defaultAction = UIAlertAction(
//                title: accept,
//                style: .default,
//                handler: completion
//            )
//
//            let cancelAction = UIAlertAction(
//                title: "Cancel",
//                style: .cancel
//            )
//
//            // Create and configure the alert controller.
//            let alert = UIAlertController(
//                title: title,
//                message: message,
//                preferredStyle: .alert
//            )
//
//            // Add buttons
//            alert.addAction(defaultAction)
//            if (hasCancel) {
//                alert.addAction(cancelAction)
//            }
//
//            viewController.present(alert, animated: true, completion: nil)
//
//        } else {
//            Log.warning("Can't use Alert until a rootViewController has been established!")
//        }
//    }
//}
