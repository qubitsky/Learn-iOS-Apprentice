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
    var iconName = "No Icon"
    init(name: String) {
        self.name = name
        super.init()
    }
    func countUncheckedItems() -> Int {
        return items.reduce(0) { cnt, item in cnt + (item.checked ? 0 : 1) }
    }
}
