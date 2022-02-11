//
//  ViewController.swift
//  Pull to refresh ( UIRefreshControl )
//
//  Created by 竣亦 on 2022/2/11.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dataArray: [String] = ["data1", "data2", "data3", "data4"]
    
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        refreshControl = UIRefreshControl()
        self.tableView.addSubview(refreshControl)
        
        refreshControl.addTarget(self, action: #selector(loadData), for: UIControl.Event.valueChanged)
    }

    @objc func loadData(){
        
        // 延遲讀取，來模擬網路延遲效果（延遲3秒）
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            // 停止refreshControl動畫
            self.refreshControl.endRefreshing()
            
            // 新建5筆假資料
            for number in self.dataArray.count + 1 ... self.dataArray.count + 4 {
                self.dataArray.append("addData\(number)")
                self.tableView.insertRows(at: [[0, self.dataArray.count - 1]], with: UITableView.RowAnimation.fade)
            }
            self.tableView.scrollToRow(at: [0, self.dataArray.count - 1], at: UITableView.ScrollPosition.bottom, animated: true)
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.dataLabel.text = dataArray[indexPath.row]
        
        return cell
    }

}

