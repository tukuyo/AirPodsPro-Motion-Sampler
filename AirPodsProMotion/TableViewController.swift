//
//  ListView.swift
//  AirPodsProMotion
//
//  Created by Yoshio on 2020/10/02.
//

import UIKit
import CoreMotion

class TableViewController: UIViewController, CMHeadphoneMotionManagerDelegate {
    
    private lazy var table :UITableView = {
        let table = UITableView(frame: self.view.bounds, style: .plain)
        table.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        table.autoresizingMask = [
          .flexibleWidth,
          .flexibleHeight
        ]
        table.rowHeight = 60
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    private var items: [Int] = []
    
    
    //AirPods Pro => APP :)
    let APP = CMHeadphoneMotionManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Table View"
        
        tableSetUp()
        
        guard APP.isDeviceMotionAvailable else { return }
        APP.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {[weak self] motion, error in
            guard let motion = motion, error == nil else { return }
            self?.motionJudge(motion)
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        APP.stopDeviceMotionUpdates()
    }

    func motionJudge(_ motion: CMDeviceMotion) {
        switch motion.attitude.pitch {
        case 0.1 ..< 0.8:
            print("Up")
            DispatchQueue.main.async {
                        self.table.contentOffset = CGPoint(x: 0, y: self.table.contentOffset.y - 10)
                    }
        case -0.8 ..< -0.1:
            print("down")
            DispatchQueue.main.async {
                        self.table.contentOffset = CGPoint(x: 0, y: self.table.contentOffset.y + 10)
                    }
        default:
            break
        }
    }
}


extension TableViewController: UITableViewDataSource {
    
    func tableSetUp() {
        table.dataSource = self
        
        Array(0...200).forEach {
            items.append($0)
        }
        view.addSubview(table)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = String(items[indexPath.row])
        return cell
    }
    
}
