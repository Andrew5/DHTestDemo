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
     
    }
    convenience init(_ title:(UIView)?,_ content:UIView,_ buttons:[UIView]){
        self.init(frame: UIScreen.main.bounds)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
