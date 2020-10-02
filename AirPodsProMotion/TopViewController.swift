//
//  TopViewController.swift
//  AirPodsProMotion
//
//  Created by Yoshio on 2020/10/02.
//

import UIKit

class TopViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private lazy var table: UITableView = {
        let table = UITableView(frame: self.view.bounds, style: .plain)
        table.autoresizingMask = [
          .flexibleWidth,
          .flexibleHeight
        ]
        table.rowHeight = 60
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    private var items: [UIViewController] = [InformationViewController(), SK3DViewController(), TableViewController()]
    private var itemTitle: [String] = ["Information View", "Rotate the Cube View", "Table scrolling by Head Motion"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "AirPodsProMotion Sampler"
        
        table.dataSource = self
        table.delegate = self
        view.addSubview(table)

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = itemTitle[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(items[indexPath.row], animated: true)
    }

}
