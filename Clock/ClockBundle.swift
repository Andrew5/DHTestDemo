//
//  ClockBundle.swift
//  Clock
//
//  Created by rilakkuma on 2022/11/12.
//

import WidgetKit
import SwiftUI

@main
struct ClockBundle: WidgetBundle {
    var body: some Widget {
        Clock()
        ClockLiveActivity()
    }
}
