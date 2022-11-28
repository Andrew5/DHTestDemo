//
//  SwiftTestClass.swift
//  MyFirstOCUseSwiftDemo
//
//  Created by jabraknight on 2019/7/24.
//  Copyright © 2019 jabraknight. All rights reserved.
//

import Foundation
//表示文件中成员可以被OC调用
@objcMembers

class Test2: NSObject {

    func show() {
        print("hello bridge!");
    }
}
