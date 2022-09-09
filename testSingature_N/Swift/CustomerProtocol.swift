//
//  CustomerProtocol.swift
//  LearnSwiftRAC
//
//  Created by rilakkuma on 2022/9/8.
//

import Foundation
import UIKit

@objc protocol OptionalProtocol {

    @objc optional func optionalMethod() //可选

    func necessaryMethod() //必须

    @objc optional func anotherOptionalMethod() //可选
}
protocol DemoProtocol {
    func fetchProductList() -> [String]?
}

protocol DemoProtocol2 {
    func methodTwo() -> String
}
// 测试
@objc protocol aaa : NSObjectProtocol {
    @objc optional func testA() //可选
}
@objc protocol bbb : NSObjectProtocol {
    @objc optional func testB() //可选
}
protocol ccc  {
    func testC()->UIView&aaa
    func testD(_ test:String, _ n:aaa&bbb)->UIView&aaa
    func testE(_ text: String) -> UIView & aaa
}
protocol ddd  {
    func testF() -> TestObject & aaa
}

@objc  protocol CustomerProtocol {
    @objc optional func createView(sumSalaryTemp:Int,salaryItems:Int)
    @objc optional func creatAlertInteractiveItem(_ text: String)->UIView&aaa
}
