//
//  CheckListItem.swift
//  checklists
//
//  Created by wang shijie on 2018/9/25.
//  Copyright © 2018 wangshijie. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject, Codable {
    var text = ""
    var checked = false
    var dueDate = Date()
    var shouldRemind = false
    var itemID: Int
    init(text: String = "", checked: Bool = false) {
        self.text = text
        self.checked = checked
        self.itemID = DataModel.nextChecklistItemID()
    }
    func toggleCheckd() {
        checked = !checked
    }
}
