//
//  SK3DViewController.swift
//  AirPodsProMotion
//
//  Created by Yoshio on 2020/09/23.
//

import UIKit
import SceneKit
import CoreMotion

class SK3DViewController: UIViewController {
    
    //AirPods Pro => APP :)
    let APP = CMHeadphoneMotionManager()
    // cube
    var cubeNode: SCNNode!
    //
    var x: Array<Double> = Array<Double>()
    var y: Array<Double> = Array<Double>()
    var z: Array<Double> = Array<Double>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        self.navigationController?.title = "Simple 3D View"

        SceneSetUp()
        
        guard APP.isDeviceMotionAvailable else { return }
        APP.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {[weak self] _,error  in
            guard error == nil else { return }
            self?.NodeRotate()
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        APP.stopDeviceMotionUpdates()
    }
    
    func NodeRotate() {
        guard APP.isDeviceMotionActive else { return }
        let data = APP.deviceMotion!.attitude
        
        
        cubeNode.eulerAngles = SCNVector3(-data.pitch, -data.yaw, -data.roll)
        
        
        // radian -> degrees
//        y.append((180 / Double.pi) * data.pitch)
//        x.append((180 / Double.pi) * data.roll)
//        z.append((180 / Double.pi) * data.yaw)
//
//        var paramX = 0.0
//        var paramY = 0.0
//        var paramZ = 0.0
//
//        // fillter
//        if x.count == 5 {
//            var xTmp = x
//            xTmp.sort()
//            paramX = xTmp[4] * 0.1
//
//            var yTmp = y
//            yTmp.sort()
//            paramY = yTmp[4] * 0.1
//
//            var zTmp = z
//            zTmp.sort()
//            paramZ = zTmp[4] * 0.1
//
//            x.removeFirst()
//            y.removeFirst()
//            z.removeFirst()
//        }
//
//        cubeNode.eulerAngles = SCNVector3(-paramY, -paramZ, -paramX)
    }
    
    //SceneKit SetUp
    func SceneSetUp() {
        let scnView = SCNView(frame: self.view.frame)
        scnView.backgroundColor = UIColor.black
        scnView.allowsCameraControl = true // ユーザーによる視点操作
        scnView.showsStatistics = true // 描画パフォーマンス情報
        view.addSubview(scnView)

        // SCNScene を SCNView に設定する
        let scene = SCNScene()
        scnView.scene = scene

        // カメラをシーンに追加する
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 15)
        scene.rootNode.addChildNode(cameraNode)

        // 無指向性の光源をシーンに追加する
        let omniLight = SCNLight()
        omniLight.type = .omni
        let omniLightNode = SCNNode()
        omniLightNode.light = omniLight
        omniLightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(omniLightNode)

        // あらゆる方向から照らす光源をシーンに追加する
        let ambientLight = SCNLight()
        ambientLight.type = .ambient
        ambientLight.color = UIColor.darkGray
        let ambientLightNode = SCNNode()
        ambientLightNode.light = ambientLight
        scene.rootNode.addChildNode(ambientLightNode)

    
        // 球体をシーンに追加する
        let cube:SCNGeometry = SCNBox(width: 3, height: 3, length: 3, chamferRadius: 0.5)
        cubeNode = SCNNode(geometry: cube)
        cubeNode.position = SCNVector3(x: 0, y: 0, z: 0)
        scene.rootNode.addChildNode(cubeNode)
    }
    
}
