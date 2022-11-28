//
//  Person.swift
//  MyFirstOCUseSwiftDemo
//
//  Created by jabraknight on 2019/10/25.
//  Copyright © 2019 jabraknight. All rights reserved.
//

import Foundation
class Person {//类
    var name: String?
    var age: Int = 0
}
@objc public protocol SelfAware: AnyObject {//协议
    @objc var weight: Int { get }
    
    static func awake()
    
    @objc optional func getName()
//    var weight:Int = 10{
//    willSet{
//
//    print("labeltext will change!")
//
//    }
//    didSet{
//    print("labeltext did change!")
//    //            labelText = "defalut"
//    }
//    }
}
public class PersionModel:NSObject {
    @objc public func test(){
        print("测试")
    }
    var name: String?
    var age: Int = 0
}
public class Student{//类
    public func run (){
           print("跑步")
       }
}
