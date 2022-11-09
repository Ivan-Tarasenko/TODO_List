//
//  ViewModel.swift
//  todo
//
//  Created by Иван Тарасенко on 07.11.2022.
//

import Foundation

final class ViewModel {

    var isSorted: Bool = true
    var isEdit: Bool = true

    // Create an array with items and add three elements to display by default
    var items: [ItemEntity] = [
        ItemEntity(title: "Task 1", completedDate: "11.12.2022", completed: false),
        ItemEntity(title: "Task 2", completedDate: "07.11.2022", completed: false),
        ItemEntity(title: "Task 3", completedDate: nil, completed: true)
    ]

    // A method that adds new tasks
    func addItem(task string: String, completedDate: String = "", isCompleted: Bool = false) {
        items.append(ItemEntity(title: string, completedDate: completedDate, completed: isCompleted))
    }

    // A method that deletes tasks
    func removeItem(at index: Int) {
        items.remove(at: index)
    }

    // A method that allows you to edit tasks
    func editItem(at index: Int, edit title: String, date: String = "", isCompleted: Bool = false) {
        items.remove(at: index)
        items.insert(ItemEntity(title: title, completedDate: date, completed: isCompleted), at: index)
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
}
