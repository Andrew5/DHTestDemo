//
//  DHCustomerAlertViewListController.swift
//  testSingature_N
//
//  Created by rilakkuma on 2022/9/5.
//

import Foundation
import UIKit

class DHCustomerAlertViewListController: UIViewController {
    fileprivate let cellid = "cell"
    var dataArr = NSArray()
//    var text: String = ""
    var text : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "LYAlertViewDemo"
        view.addSubview(tableView)
        dataArr = [
            "默认alpha动画",
            "缩放动画",
            "顶部掉落弹性动画",
            "底部弹出弹性动画",
            "左侧弹出弹性动画",
            "右侧弹出弹性动画",
            "顶部靠左掉落动画",
            "顶部靠右掉落动画",
            "带弹框的"
        ]
    }
    lazy var tableView : UITableView = {
        let table = UITableView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height), style: .plain)
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellid)
        table.tableFooterView = UIView()
        return table
    }()
}
extension DHCustomerAlertViewListController : UITableViewDelegate,UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath)
        cell.textLabel?.text = (dataArr[indexPath.row] as! String)
        cell.backgroundColor = UIColor.white
        cell.selectionStyle = .none
        return cell
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0{
            let item1 = LYAlertFactory()
                .creatAlertShowItem(.title, "温馨提示")
                .fontSize(17)
                .titleColor(UIColor.darkGray)
            let item2 = LYAlertFactory()
                .creatAlertShowItem(.content, "是否确认向老师发起一对一错题辅导请求？")
                .fontSize(16)
                .titleColor(UIColor.darkGray)
                .line(UIColor.lightGray, 0.5)
            let item3 = LYAlertFactory()
                .creatAlertInteractiveItem("我再想想")
                .fontSize(15)
                .btnHeight(30)
                .btnMarin(10)
                .titleColor(UIColor.gray)
                .line(UIColor.lightGray, 0.5, .left)
                .action {
                     print("我再想想")
                }
            let item4 = LYAlertFactory()
                .creatAlertInteractiveItem("确认发起")
                .fontSize(15)
                .btnHeight(30)
                .btnMarin(10)
                .titleColor(UIColor.brown)
                .line(UIColor.lightGray, 0.5, .left)
                .action {
                    print("确认发起")
                }
            let alert = LYAlertBuilder.init(item1, item2, [item3,item4])
                .cornerRadius(15)
                .maskAlpha(0.4)
                .build()
            alert?.show()
        }else if indexPath.row == 1{
            let item2 = LYAlertFactory()
                .creatAlertShowItem(.content, "是否确认向老师发起一对一错题辅导请求？")
                .fontSize(16)
                .titleColor(UIColor.darkGray)
                .line(UIColor.lightGray, 0.5)
            let item3 = LYAlertFactory()
                .creatAlertInteractiveItem("我再想想")
                .fontSize(15)
                .btnHeight(30)
                .btnMarin(10)
                .titleColor(UIColor.gray)
                .line(UIColor.lightGray, 0.5, .left)
                .action {
                     print("我再想想")
                }
            let item4 = LYAlertFactory()
                .creatAlertInteractiveItem("确认发起")
                .fontSize(15)
                .btnHeight(30)
                .btnMarin(10)
                .titleColor(UIColor.brown)
                .line(UIColor.lightGray, 0.5, .left)
                .action {
                    print("确认发起")
                }
            let alert = LYAlertBuilder.init(nil, item2, [item3,item4])
                .cornerRadius(15)
                .maskAlpha(0.4)
                .showAnimation(.scale, 0.5)
                .hideAnimation(.scale, 0.5)
                .build()
            alert?.show()
        }else if indexPath.row == 2{
           
            let item1 = LYAlertFactory()
                .creatAlertShowItem(.title, "温馨提示")
                .fontSize(17)
                .titleColor(UIColor.darkGray)
            let item2 = LYAlertFactory()
                .creatAlertShowItem(.content, "是否确认向老师发起一对一错题辅导请求？")
                .fontSize(16)
                .titleColor(UIColor.darkGray)
                .line(UIColor.lightGray, 0.5)
            let item3 = LYAlertFactory()
                .creatAlertInteractiveItem("我再想想")
                .fontSize(15)
                .btnHeight(44)
                .btnMarin(15)
                .btnRadius(5)
                .btnBackgroundColor(UIColor.orange)
                .titleColor(UIColor.white)
                .line(UIColor.lightGray, 0.5, .left)
                .action {
                     print("我再想想")
                }
            let item4 = LYAlertFactory()
                .creatAlertInteractiveItem("确认发起")
                .fontSize(15)
                .btnRadius(5)
                .btnHeight(44)
                .btnMarin(15)
                .btnBackgroundColor(UIColor.orange)
                .titleColor(UIColor.white)
                .line(UIColor.lightGray, 0.5, .left)
                .action {
                    print("确认发起")
                }
            let alert = LYAlertBuilder.init(item1, item2, [item3,item4])
                .cornerRadius(15)
                .maskAlpha(0.6)
                .showAnimation(.shakeFromTop, 0.5)
                .hideAnimation(.shakeToTop, 0.5)
                .build()
            alert?.show()
        }else if indexPath.row == 3{
            
            let item1 = LYAlertFactory()
                .creatAlertShowItem(.title, "温馨提示")
                .fontSize(17)
                .line(UIColor.lightGray, 0.5)
                .titleColor(UIColor.darkGray)
            let item2 = LYAlertFactory()
                .creatAlertShowItem(.content, "是否确认向老师发起一对一错题辅导请求是否确认向老师发起一对一错题辅导请求是否确认向老师发起一对一错题辅导请求是否确认向老师发起一对一错题辅导请求是否确认向老师发起一对一错题辅导请求？")
                .fontSize(16)
                .textAlignment(.justified)
                .titleColor(UIColor.darkGray)
                .line(UIColor.lightGray, 0.5)
            let item3 = LYAlertFactory()
                .creatAlertInteractiveItem("我再想想")
                .fontSize(15)
                .btnHeight(44)
                .btnMarin(15)
                .btnRadius(5)
                .btnBackgroundColor(UIColor.orange)
                .titleColor(UIColor.white)
                .line(UIColor.lightGray, 0.5, .left)
                .action {
                     print("我再想想")
                }
            let item4 = LYAlertFactory()
                .creatAlertInteractiveItem("确认发起")
                .fontSize(15)
                .btnRadius(5)
                .btnHeight(44)
                .btnMarin(15)
                .btnBackgroundColor(UIColor.orange)
                .titleColor(UIColor.white)
                .line(UIColor.lightGray, 0.5, .left)
                .action {
                    print("确认发起")
                }
            let alert = LYAlertBuilder.init(item1, item2, [item3,item4])
                .cornerRadius(15)
                .maskAlpha(0.6)
                .showAnimation(.shakeFromBottom, 0.5)
                .hideAnimation(.shakeToTop, 0.5)
                .build()
            alert?.show()
        }else if indexPath.row == 4{
            let dic = [NSAttributedString.Key.kern:NSNumber.init(value: 15)]
            let item1 = LYAlertFactory()
                .creatAlertShowItem(.title, "温馨提示")
                .fontSize(17)
                .attribute(dic)
                .titleColor(UIColor.darkGray)
            let item2 = LYAlertFactory()
                .creatAlertShowItem(.content, "是否确认向老师发起一对一错题辅导请求？")
                .fontSize(16)
                .titleColor(UIColor.darkGray)
                .line(UIColor.lightGray, 0.5)
         
            let item4 = LYAlertFactory()
                .creatAlertInteractiveItem("确认发起")
                .fontSize(15)
                .btnRadius(5)
                .btnHeight(44)
                .btnMarin(15)
                .btnBackgroundColor(UIColor.orange)
                .titleColor(UIColor.white)
                .action {
                    print("确认发起")
                }
            let alert = LYAlertBuilder.init(item1, item2, [item4])
                .cornerRadius(15)
                .maskAlpha(0.6)
                .showAnimation(.shakeFromLeft, 0.5)
                .hideAnimation(.shakeToLeft, 0.5)
                .build()
            alert?.show()
        }else if indexPath.row == 5{
            let item1 = LYAlertFactory()
                .creatAlertShowItem(.title, "温馨提示")
                .fontSize(17)
                .titleColor(UIColor.darkGray)
            let item2 = LYAlertFactory()
                .creatAlertShowItem(.content, "是否确认向老师发起一对一错题辅导请求？")
                .fontSize(16)
                .titleColor(UIColor.darkGray)
                .line(UIColor.lightGray, 0.5)
            let item3 = LYAlertFactory()
                .creatAlertInteractiveItem("我再想想")
                .fontSize(15)
                .btnHeight(30)
                .btnMarin(10)
                .titleColor(UIColor.gray)
                .line(UIColor.lightGray, 0.5, .bottom)
                .action {
                     print("我再想想")
                }
            let item4 = LYAlertFactory()
                .creatAlertInteractiveItem("确认发起")
                .fontSize(15)
                .btnHeight(30)
                .btnMarin(10)
                .titleColor(UIColor.brown)
                .line(UIColor.lightGray, 0.5, .bottom)
                .action {
                    print("确认发起")
                }
            let item5 = LYAlertFactory()
                .creatAlertInteractiveItem("取消")
                .fontSize(15)
                .btnHeight(30)
                .btnMarin(10)
                .titleColor(UIColor.brown)
                .action {
                    print("取消")
                }
            let alert = LYAlertBuilder.init(item1, item2, [item3,item4,item5])
                .cornerRadius(15)
                .maskAlpha(0.4)
                .showAnimation(.shakeFromRight, 0.5)
                .hideAnimation(.shakeToLeft, 0.5)
                .build()
            alert?.show()
        }else if indexPath.row == 6{
            let item1 = LYAlertFactory()
                .creatAlertShowItem(.title, "温馨提示")
                .fontSize(17)
                .titleColor(UIColor.darkGray)
            let item2 = LYAlertFactory()
                .creatAlertShowItem(.content, "是否确认向老师发起一对一错题辅导请求？")
                .fontSize(16)
                .titleColor(UIColor.darkGray)
                .line(UIColor.lightGray, 0.5)
            let item3 = LYAlertFactory()
                .creatAlertInteractiveItem("我再想想")
                .fontSize(15)
                .btnHeight(44)
                .btnMarin(0)
                .itemBackgroundColor(UIColor.orange)
                .btnBackgroundColor(UIColor.clear)
                .titleColor(UIColor.white)
                .line(UIColor.gray, 0.5, .left)
                .action {
                     print("我再想想")
                }
            let item4 = LYAlertFactory()
                .creatAlertInteractiveItem("确认发起")
                .fontSize(15)
                .btnHeight(44)
                .btnMarin(0)
                .itemBackgroundColor(UIColor.orange)
                .titleColor(UIColor.white)
                .action {
                    print("确认发起")
                }
            let alert = LYAlertBuilder.init(item1, item2, [item3,item4])
                .cornerRadius(15)
                .maskAlpha(0.6)
                .showAnimation(.dropFromLeft, 0.5)
                .hideAnimation(.dropFromLeft, 0.5)
                .build()
            alert?.show()
        }else  if indexPath.row == 7{
            let item1 = LYAlertFactory()
                .creatAlertShowItem(.title, "温馨提示")
                .fontSize(17)
                .titleColor(UIColor.darkGray)
            let item2 = LYAlertFactory()
                .creatAlertShowItem(.content, "是否确认向老师发起一对一错题辅导请求？")
                .fontSize(16)
                .titleColor(UIColor.darkGray)
                .line(UIColor.lightGray, 0.5)
    
            let item4 = LYAlertFactory()
                .creatAlertInteractiveItem("确认发起")
                .fontSize(15)
                .btnHeight(44)
                .btnMarin(0)
                .itemBackgroundColor(UIColor.orange)
                .titleColor(UIColor.white)
                .action {
                    print("确认发起")
                }
            let alert = LYAlertBuilder.init(item1, item2, [item4])
                .cornerRadius(15)
                .maskAlpha(0.6)
                .showAnimation(.dropFromRight, 0.5)
                .hideAnimation(.dropFromRight, 0.5)
                .build()
            alert?.show()
        }else  if indexPath.row == 8{
            let item1 = LYAlertFactory()
                .creatAlertShowItem(.title, "温馨提示")
                .fontSize(17)
                .titleColor(UIColor.darkGray)
            let item2 = LYAlertFactory()
                .creatAlertFieldItem("请输入老师的ID以发起辅导请求")
                .fontSize(16)
                .delegate(self)
                .titleColor(UIColor.darkGray)
                .keyboardType(.default)
                .line(UIColor.lightGray, 0.5)
    
            let item4 = LYAlertFactory()
                .creatAlertInteractiveItem("确认发起")
                .fontSize(15)
                .btnHeight(44)
                .btnMarin(0)
                .itemBackgroundColor(UIColor.orange)
                .titleColor(UIColor.white)
                .action { [weak self] in
//                    print("老师ID:\(String(describing: self?.text))")//Optional("I’m going back to the house ")
                    print("老师ID:\(self?.text ?? "")")
                    if let _ = self?.text {
                        print("text有值")
                    } else {
                        print("text为空")
                    }
                }
            let alert = LYAlertBuilder.init(item1, item2, [item4])
                .cornerRadius(15)
                .maskAlpha(0.6)
                .tapMaskHide(false)
                .showAnimation(.dropFromRight, 0.5)
                .hideAnimation(.dropFromRight, 0.5)
                .build()
            alert?.show()
        }
    }
}
extension DHCustomerAlertViewListController:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let s = textField.text{
            self.text = (s + string as NSString) as String
        }
        return true
    }
}
