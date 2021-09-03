//
//  ViewController.swift
//  AirPodsProMotion
//
//  Created by Yoshio on 2020/09/22.
//

import UIKit
import CoreMotion

class InformationViewController: UIViewController, CMHeadphoneMotionManagerDelegate {

    lazy var textView: UITextView = {
        let view = UITextView()
        view.frame = CGRect(x: self.view.bounds.minX + (self.view.bounds.width / 10),
                            y: self.view.bounds.minY + (self.view.bounds.height / 6),
                            width: self.view.bounds.width, height: self.view.bounds.height)
        view.text = "Looking for AirPods Pro"
        view.font = view.font?.withSize(14)
        view.isEditable = false
        return view
    }()
    
    
    
    //AirPods Pro => APP :)
    let APP = CMHeadphoneMotionManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Information View"
        view.backgroundColor = .systemBackground
        view.addSubview(textView)
        
        
        APP.delegate = self
        
        guard APP.isDeviceMotionAvailable else {
            self.Alert("Sorry", "Your device is not supported.")
            textView.text = "Sorry, Your device is not supported."
            return
        }
        
        APP.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {[weak self] motion, error  in
            guard let motion = motion, error == nil else { return }
            self?.printData(motion)
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        APP.stopDeviceMotionUpdates()
    }
    
    
    func printData(_ data: CMDeviceMotion) {
        print(data)
        self.textView.text = """
            Quaternion:
                x: \(data.attitude.quaternion.x)
                y: \(data.attitude.quaternion.y)
                z: \(data.attitude.quaternion.z)
                w: \(data.attitude.quaternion.w)
            Attitude:
                pitch: \(data.attitude.pitch)
                roll: \(data.attitude.roll)
                yaw: \(data.attitude.yaw)
            Gravitational Acceleration:
                x: \(data.gravity.x)
                y: \(data.gravity.y)
                z: \(data.gravity.z)
            Rotation Rate:
                x: \(data.rotationRate.x)
                y: \(data.rotationRate.y)
                z: \(data.rotationRate.z)
            Acceleration:
                x: \(data.userAcceleration.x)
                y: \(data.userAcceleration.y)
                z: \(data.userAcceleration.z)
            Magnetic Field:
                field: \(data.magneticField.field)
                accuracy: \(data.magneticField.accuracy)
            Heading:
                \(data.heading)
            """
    }
}
