//
//  ObjectManageer.swift
//  testSingature_N
//
//  Created by rilakkuma on 2022/9/8.
//

import Foundation
import HandyJSON
class testview:UIView ,CustomerProtocol,aaa{
    func creatAlertInteractiveItem(_ text: String) -> UIView & aaa {
        return testview() 
    }
}

class TestObject: testview,ddd{
    func testF() -> TestObject & aaa {
        return TestObject()
    }
    
    func testA() {
        
    }
  
}
