//
//  CSVWriter.swift
//
//  I created CSVWriter with reference to the following repositories and articles (in Japanese).
//  GitHub         : https://github.com/yorifuji/CMHeadphoneMotionManager-Sampler
//  Article (Zenn) : https://zenn.dev/yorifuji/articles/1632a1d8ff6f3b98c134
//
//  Created by Yoshio on 2020/11/11.
//

import Foundation
import CoreMotion


class CSVWriter {
    
    var file: FileHandle?
    
    func open(_ filePath: URL) {
        do {
            FileManager.default.createFile(atPath: filePath.path, contents: nil, attributes: nil)
            file = try FileHandle(forWritingTo: filePath)
            header()
        } catch let e {
            print(e)
        }
        
    }
    
    func header(){
        let header = """
                    QuaternionX,QuaternionY,QuaternionZ,QuaternionW,\
                    AttitudePitch,AttitudeRoll,AttitudeYaw,\
                    GravitationalAccelerationX,GravitationalAccelerationY,GravitationalAccelerationZ,\
                    AccelerationX,AccelerationY,AccelerationZ,\
                    RotationX,RotationY,RotationZ\n
                    """
        file!.write(header.data(using: .utf8)!)
    }
    
    func write(_ motion: CMDeviceMotion) {
        guard let file = self.file else { return }
        var text = """
                \(motion.attitude.quaternion.x),\(motion.attitude.quaternion.y),\(motion.attitude.quaternion.z),\(motion.attitude.quaternion.w),\
                \(motion.attitude.pitch),\(motion.attitude.roll),\(motion.attitude.yaw),\
                \(motion.gravity.x),\(motion.gravity.y),\(motion.gravity.z),\
                \(motion.userAcceleration.x),\(motion.userAcceleration.y),\(motion.userAcceleration.z),\
                \(motion.rotationRate.x),\(motion.rotationRate.y),\(motion.rotationRate.z)
                """
        text = text.trimmingCharacters(in: .newlines) + "\n"
        file.write(text.data(using: .utf8)!)
    }
    
    func close() {
        guard let _ = self.file else { return }
        file!.closeFile()
        file = nil
    }
}

