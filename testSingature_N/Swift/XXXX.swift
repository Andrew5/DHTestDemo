//
//  XXXX.swift
//  testSingature_N
//
//  Created by rilakkuma on 2022/9/5.
//

import Foundation
import UIKit

final class XXXView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        var gridArray : [[UIView]] = [[UIView]]()
        var xxview=UIView.init()
//        self.init(xxview, xxview, [gridArray])
        print("XXXView 初始化")

    }
    convenience init(_ title:(UIView)?,_ content:UIView,_ buttons:[UIView]){
        self.init(frame: UIScreen.main.bounds)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

extension Bundle {
     static func libRestBundle() -> Bundle {
        let bundle = Bundle.init(identifier: "org.cocoapods.ActivityManualListening")!
        return bundle
    }
}

extension UIImage {
    convenience init(activityManualListenImageName: String) {
        let trait = UITraitCollection.init(displayScale: UIScreen.main.scale)
        self.init(named: activityManualListenImageName, in: Bundle.libRestBundle(), compatibleWith: trait)!
    }
}

//UIImage.init(activityManualListenImageName: "test")


