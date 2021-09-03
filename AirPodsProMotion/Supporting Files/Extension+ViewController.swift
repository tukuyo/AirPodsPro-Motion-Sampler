//
//  Extension+ViewController.swift
//  AirPodsProMotion
//
//  Created by Yoshio on 2021/09/03.
//

import UIKit

extension UIViewController {
    func Alert(_ title: String, _ message: String) {
        let dialog = UIAlertController(title: title, message: message, preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(dialog, animated: true, completion: nil)
    }
}
