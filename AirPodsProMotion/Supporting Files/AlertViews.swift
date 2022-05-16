//
//  AlertViews.swift
//  AirPodsProMotion
//
//  Created by Yoshio on 2022/05/10.
//

import Foundation
import UIKit

final class AlertView {
    static func alert(_ vc: UIViewController, _ title: String, _ message: String) {
        let dialog = UIAlertController(title: title, message: message, preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(dialog, animated: true, completion: nil)
    }
    
    static func warning(_ vc: UIViewController, handler: ((UIAlertAction) -> Void)? = nil, animated: Bool = true) {
        let alert = UIAlertController(title: "Oops...", message: "Sorry", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
        vc.present(alert, animated: animated, completion: nil)
    }
    
    static func action(_ vc: UIViewController, handler: ((UIAlertAction) -> Void)? = nil, animated: Bool = true) {
        let action = UIAlertController(title: "File save complete.", message: "You can check the data by using a file App.", preferredStyle: .alert)
        action.addAction(UIAlertAction(title: "Check Now", style: .default, handler: handler))
        action.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc.present(action, animated: animated, completion: nil)
    }
}
