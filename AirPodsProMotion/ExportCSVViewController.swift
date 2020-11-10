//
//  ExportCSV.swift
//  AirPodsProMotion
//
//  Created by Yoshio on 2020/11/10.
//

import Foundation
import UIKit
import CoreMotion

class ExportCSVViewController: UIViewController, CMHeadphoneMotionManagerDelegate {
    
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: self.view.bounds.width / 4, y: self.view.bounds.maxY - 100,
                              width: self.view.bounds.width / 2, height: 50)
        button.setTitle("Start",for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.layer.cornerRadius = 10
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(Tap), for: .touchUpInside)
        
        return button
    }()
    
    lazy var textView: UITextView = {
        let view = UITextView()
        view.frame = CGRect(x: self.view.bounds.minX + (self.view.bounds.width / 10),
                            y: self.view.bounds.minY + (self.view.bounds.height / 6),
                            width: self.view.bounds.width, height: self.view.bounds.height - 300)
        view.text = "Press the start button below to start recording."
        view.font = view.font?.withSize(14)
        view.isEditable = false
        return view
    }()
    
    
    //AirPods Pro => APP :)
    let APP = CMHeadphoneMotionManager()
    
    let writer = CSVWriter()
    let f = DateFormatter()
    
    var write: Bool = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Information View"
        view.backgroundColor = .systemBackground
        view.addSubview(button)
        view.addSubview(textView)
        
        f.dateFormat = "yyyyMMdd_HHmmss"

        APP.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        write = false
        writer.close()
        APP.stopDeviceMotionUpdates()
        button.setTitle("Start", for: .normal)
    }
    
    func start() {
        guard APP.isDeviceMotionAvailable else { return }
        APP.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {[weak self] motion, error  in
            guard let motion = motion, error == nil else { return }
                self?.writer.write(motion)
            self?.printData(motion)
        })
    }
    
    @objc func Tap() {
        if write {
            write.toggle()
            writer.close()
            APP.stopDeviceMotionUpdates()
            button.setTitle("Start", for: .normal)
        } else {
            write.toggle()
            button.setTitle("Stop", for: .normal)
            let dir = FileManager.default.urls(
              for: .documentDirectory,
              in: .userDomainMask
            ).first!
            
            let now = Date()
            let filename = f.string(from: now) + "_motion.csv"
            
            let fileUrl = dir.appendingPathComponent(filename)
            writer.open(fileUrl)
            start()
        }
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
            """
    }
}
