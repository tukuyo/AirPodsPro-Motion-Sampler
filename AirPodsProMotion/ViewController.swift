//
//  ViewController.swift
//  AirPodsProMotion
//
//  Created by Yoshio on 2020/09/22.
//

import UIKit
import CoreMotion

class ViewController: UIViewController, CMHeadphoneMotionManagerDelegate {

    @IBOutlet var textView: UITextView!
    
    //AirPods Pro => APP :)
    let APP = CMHeadphoneMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        APP.delegate = self
        
        guard APP.isDeviceMotionAvailable else { return }
        APP.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {[weak self] motion, error  in
            guard let motion = motion, error == nil else { return }
            self?.printData(motion)
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewDidLoad()
    }
    
    func printData(_ data: CMDeviceMotion) {

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

    @IBAction func nextView(_ sender: Any) {
        APP.stopDeviceMotionUpdates()
        
        self.navigationController?.pushViewController(SK3DViewController(), animated: true)
    }
}
