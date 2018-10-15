//
//  ViewController.swift
//  checklists
//
//  Created by wangshijie on 2018/9/21.
//  Copyright © 2018 wangshijie. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController, ItemDetailViewControllerDelegate {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
        navigationController?.popViewController(animated:true)
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem) {
        let newRowIndex = checklist.items.count
        checklist.items.append(item)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated:true)
//        saveChecklistItems()
    }
    
    func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem) {
        if let index = checklist.items.index(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }
        navigationController?.popViewController(animated:true)
//        saveChecklistItems()
    }

    var checklist: Checklist!
    
//    func documentsDirectory() -> URL {
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        return paths[0]
//    }
//
//    func dataFilePath() -> URL {
//        return documentsDirectory().appendingPathComponent("Checklist.plist")
//    }
//
//    func saveChecklistItems() {
//        let encoder = PropertyListEncoder()
//        do {
//            let data = try encoder.encode(checklist.items)
//            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
//        } catch {
//            print("Error encoding item array")
//        }
//    }
//
//    func loadCheckListItems() {
//        let path = dataFilePath()
//        if let data = try? Data(contentsOf: path) {
//            let decoder = PropertyListDecoder()
//            do {
//                checklist.items = try decoder.decode([ChecklistItem].self, from: data)
//            } catch {
//                print("Error decoding item array")
//            }
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.largeTitleDisplayMode = .never
//        loadCheckListItems()
        title = checklist.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checklist.items.count
    }
    
    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?) {
        // 1
        if segue.identifier == "AddItem" {
            // 2
            let controller = segue.destination
                as! ItemDetailViewController
            // 3
            controller.delegate = self
        } else if segue.identifier == "EditItem" {
            let controller = segue.destination as! ItemDetailViewController
            controller.delegate = self
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controller.itemToEdit = checklist.items[indexPath.row]
            }
        }
    }

    func configureCheckmark(for cell: UITableViewCell,
                            with item: ChecklistItem) {
        let label = cell.viewWithTag(1001) as! UILabel

        if item.checked {
            label.text = "√"
        } else {
            label.text = ""
        }
        label.textColor = view.tintColor
    }

    func configureText(for cell: UITableViewCell,
                       with item: ChecklistItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = "\(item.itemID): \(item.text)"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListItem", for: indexPath)
        let item = checklist.items[indexPath.row]
        // Add the following code
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        // End of new code block
        return cell
    }

    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = checklist.items[indexPath.row]
            item.toggleCheckd()
            configureCheckmark(for: cell, with: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
//        saveChecklistItems()
    }
    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCellEditingStyle,
        forRowAt indexPath: IndexPath) { 
        // 1
        checklist.items.remove(at: indexPath.row)
        
        // 2
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        
//        saveChecklistItems()
    }
}

