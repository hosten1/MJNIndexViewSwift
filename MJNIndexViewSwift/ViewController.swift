//
//  ViewController.swift
//  MJNIndexViewSwift
//
//  Created by VRV2 on 2017/9/19.
//  Copyright © 2017年 Hosten_lym. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    fileprivate var indexView :MJNIndexViewSwift?
    fileprivate var tableView :UITableView?
    fileprivate lazy var  memberLists:[String] = {
        let memberList = ["A","B","C","D","E","F","G","H","I","J","K","L","M","*"]
        return memberList
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //添加一tableveiw
        let tableView = UITableView()
        self.tableView = tableView
        tableView.frame = self.view.bounds
        self.view .addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        self.loadIndexView()
    }
    func loadIndexView() {
        let screenWid = UIScreen.main.bounds.size.width
        let screenHei = UIScreen.main.bounds.size.height
        if indexView == nil {
            indexView = MJNIndexViewSwift.init(frame: CGRect.init(x: 0, y: 0, width: screenWid, height: screenHei-64))
            indexView?.dataSource = self
            indexView?.font = UIFont.systemFont(ofSize: 13)
            indexView?.fontColor =  UIColor.init(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0)
            //            InitSetFontColor(fontColor: UIColor.init(red: 0.3, green: 0.3, blue: 0.3, alpha: 1.0))
            self.view.addSubview(indexView!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension ViewController:UITableViewDataSource,UITableViewDelegate,MJNIndexViewSwiftDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return memberLists.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let ID = "Cell"
        
        // 从缓冲池中取出cell
        var cell = tableView.dequeueReusableCell(withIdentifier: ID)
        
        // 判断是否为nil,如果为nil,则创建
        if cell == nil {
            
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: ID)
        }
        
        cell?.textLabel?.text = "测试数据\(indexPath.row)"
        
        return cell!
    }
    
    // MARK:- tableView代理方法
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("点击了\(indexPath.row)")
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title = UILabel.init(frame: CGRect.init(x: 20, y: 0, width: self.view.frame.size.width, height: 20))
        title.backgroundColor = UIColor.clear
        title.textAlignment = .left
        title.textColor = UIColor.gray
        title.font = UIFont.systemFont(ofSize: 14)
        let sectionTitle = memberLists[section]
        title.text = sectionTitle == "@" ? "管理员" : sectionTitle
        return title
        
    }
    
    
    func swiftSectionFor(SectionMJNIndexTitle title: String, atIndex index: Int) {
        tableView?.scrollToRow(at: NSIndexPath.init(item: 0, section: index) as IndexPath, at:.top , animated: (self.indexView?.getSelectedItemsAfterPanGestureIsFinished)!)
    }
    func swiftSectionIndexTitles(ForMJNIndexView indexView: MJNIndexViewSwift) -> ([String]) {
        
        if memberLists.count > 0 {
            return memberLists
        }
        return [String]()
    }
}
