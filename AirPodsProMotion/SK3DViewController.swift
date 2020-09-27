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
    
    // Filter variables (not used in this case)
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
//        // filter
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
        scnView.allowsCameraControl = false
        scnView.showsStatistics = true
        view.addSubview(scnView)

        // Set SCNScene to SCNView
        let scene = SCNScene()
        scnView.scene = scene

        // Adding a camera to a scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 15)
        scene.rootNode.addChildNode(cameraNode)

        // Adding an omnidirectional light source to the scene
        let omniLight = SCNLight()
        omniLight.type = .omni
        let omniLightNode = SCNNode()
        omniLightNode.light = omniLight
        omniLightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(omniLightNode)

        // Adding a light source to your scene that illuminates from all directions.
        let ambientLight = SCNLight()
        ambientLight.type = .ambient
        ambientLight.color = UIColor.darkGray
        let ambientLightNode = SCNNode()
        ambientLightNode.light = ambientLight
        scene.rootNode.addChildNode(ambientLightNode)

    
        // Adding a cube to a scene
        let cube:SCNGeometry = SCNBox(width: 3, height: 3, length: 3, chamferRadius: 0.5)
        cubeNode = SCNNode(geometry: cube)
        cubeNode.position = SCNVector3(x: 0, y: 0, z: 0)
        scene.rootNode.addChildNode(cubeNode)
    }
    
}
