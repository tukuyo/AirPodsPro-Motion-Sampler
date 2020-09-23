//
//  ViewController.swift
//  AirPodsProMotion
//
//  Created by Yoshio on 2020/09/22.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    @IBOutlet var textView: UITextView!
    //AirPods Pro => APP :)
    let APP = CMHeadphoneMotionManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        guard APP.isDeviceMotionAvailable else { return }
        APP.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {[weak self] _,error  in
            guard error == nil else { return }
            self?.printData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewDidLoad()
    }
    
    func printData() {
        guard APP.isDeviceMotionActive else { return }
        let data = APP.deviceMotion!
//        print(data)
//        print(data.attitude)            // 姿勢 pitch, roll, yaw
//        print(data.gravity)             // 重力加速度
//        print(data.rotationRate)        // 角速度
//        print(data.userAcceleration)    // 加速度
//        print(data.magneticField)       // 磁気フィールド　磁気ベクトルを返す
//        print(data.heading)             // 方位角
        
        self.textView.text = """
            Quaternion:
                x: \(data.attitude.quaternion.x)
                y: \(data.attitude.quaternion.y)
                z: \(data.attitude.quaternion.z)
                w: \(data.attitude.quaternion.w)
            姿勢:
                pitch: \(data.attitude.pitch)
                roll: \(data.attitude.roll)
                yaw: \(data.attitude.yaw)
            重力加速度:
                x: \(data.gravity.x)
                y: \(data.gravity.y)
                z: \(data.gravity.z)
            角速度:
                x: \(data.rotationRate.x)
                y: \(data.rotationRate.y)
                z: \(data.rotationRate.z)
            加速度:
                x: \(data.userAcceleration.x)
                y: \(data.userAcceleration.y)
                z: \(data.userAcceleration.z)
            磁気フィールド:
                field: \(data.magneticField.field)
                accuracy: \(data.magneticField.accuracy)
            方位角:
                \(data.heading)
            """
    }

    @IBAction func DView(_ sender: Any) {
        APP.stopDeviceMotionUpdates()
        
        self.navigationController?.pushViewController(SK3DViewController(), animated: true)
    }
}
