//
//  Checklist.swift
//  checklists
//
//  Created by wang shijie on 2018/10/5.
//  Copyright © 2018 wangshijie. All rights reserved.
//

import UIKit

class Checklist: NSObject, Codable {
    var name = ""
    var items = [ChecklistItem]()
    var iconName = "没有图标"
    init(name: String, iconName: String = "没有图标") {
        self.name = name
        self.iconName = iconName
        super.init()
    }
    func countUncheckedItems() -> Int {
        return items.reduce(0) { cnt, item in cnt + (item.checked ? 0 : 1) }
    }
}
