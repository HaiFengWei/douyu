//
//  ViewController.swift
//  yhnote
//
//  Created by 韦海峰 on 2018/11/15.
//  Copyright © 2018 sepeak. All rights reserved.
//

import UIKit

let cellID : NSString = "listTabbleViewCellID"

class ViewController: UIViewController {

    private var dataSourceArray : NSArray = ["算术","图片笔记（TODO）","日常工具（TODO）"]
    // MARK: - Lazy Load
    private lazy var listTabbleView : UITableView = { [weak self] in
        let listTabbleView = UITableView(frame: CGRect.zero, style: UITableView.Style.plain)
        listTabbleView.delegate   = self
        listTabbleView.dataSource = self
        listTabbleView.rowHeight  = 44.0
        listTabbleView.tableFooterView  = UIView()
        return listTabbleView
        }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension ViewController {
    func setupUI()  {
        view.backgroundColor = UIColor.white
        listTabbleView.backgroundColor = UIColor.white
        
        setNavigationBar()
        
        view.addSubview(self.listTabbleView)
        self.listTabbleView.snp.makeConstraints { (make) in
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.top.equalTo(view)
            make.bottom.equalTo(view)
        }
    }
    
    func setNavigationBar() {
        let versionBtn = UIButton()
        versionBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        versionBtn.setTitle("版本信息", for: UIControl.State.normal)
        versionBtn.setTitleColor(UIColor(red:0.26, green:0.51, blue:0.89, alpha:1.00), for: UIControl.State.normal)
        versionBtn.addTarget(self, action: #selector(versionBarBtnClick), for: UIControl.Event.touchUpInside)
        versionBtn.sizeToFit()
        let versionBarBtn = UIBarButtonItem.init(customView: versionBtn)
        self.navigationItem.rightBarButtonItem = versionBarBtn
    }
}

extension ViewController {
    @objc func versionBarBtnClick() {
        let noticeView : SPNoticeView = SPNoticeView.init(noticeTitle: "炮仗笔记\n1.0测试版研发中\n叶慧VIP定制", showTime: 3.0)
        noticeView.show()
    }
}


// MARK: - UITableViewDataSource
extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSourceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellID as String)
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: cellID as String)
            cell?.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        }
        
        cell?.textLabel?.text = (self.dataSourceArray[indexPath.row] as! String)
        return cell!
    }
    
    
}


// MARK: - UITableViewDelegate
extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            let vc = CalculationController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let noticeView : SPNoticeView = SPNoticeView.init(noticeTitle: "炮仗，海风哥哥开发中", showTime: 2.0)
            noticeView.show()
        }
    }
}

