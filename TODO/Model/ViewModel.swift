//
//  ViewModel.swift
//  todo
//
//  Created by Иван Тарасенко on 07.11.2022.
//

import Foundation

protocol ViewModelProtocol {
    var isSorted: Bool {get set}
    var isEdit: Bool {get set}
    var items: [ItemEntity] {get set}

    func addItem(task string: String, completedDate: String, isCompleted: Bool)
    func removeItem(at index: Int)
    func editItem(at index: Int, edit title: String, date: String)
    func sortItemByTitle()
    func changeState(at index: Int) -> Bool
    func search(searchText: String)
}

final class ViewModel: ViewModelProtocol {

    var isSorted: Bool = true
    var isEdit: Bool = true

    // Create an array with items and add three elements to display by default
    var items: [ItemEntity] = [
        ItemEntity(title: "Get some sleep", completedDate: "11.12.2022", completed: false),
        ItemEntity(title: "Finish app", completedDate: "07.11.2022", completed: false),
        ItemEntity(title: "Work", completedDate: "", completed: true)
    ]

    // A method that adds new tasks
    func addItem(task string: String, completedDate: String = "", isCompleted: Bool) {
        items.append(ItemEntity(title: string, completedDate: completedDate, completed: isCompleted))
    }

    // A method that deletes tasks
    func removeItem(at index: Int) {
        items.remove(at: index)
    }

    // A method that allows you to edit tasks
    func editItem(at index: Int, edit title: String, date: String = "") {
       let removeItem = items.remove(at: index)
        var completionTime = date

        if date.isEmpty {
            completionTime = removeItem.completedDate
        }
        items.insert(ItemEntity(title: title, completedDate: completionTime, completed: removeItem.completed), at: index)
    }

    func sortItemByTitle() {
        if isSorted {
            items.sort {$0.title < $1.title}
        } else {
            items.sort {$0.title > $1.title}
        }
    }

    func changeState(at index: Int) -> Bool {
        items[index].completed = !items[index].completed
        return items[index].completed
    }

    func search(searchText: String) {
        for (index, item) in items.enumerated() where item.title ~= searchText {
            let removeItem = items.remove(at: index)
            items.insert(removeItem, at: 0)
        }
    }
}
