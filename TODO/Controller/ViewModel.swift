//
//  ViewModel.swift
//  todo
//
//  Created by Иван Тарасенко on 07.11.2022.
//

import Foundation

final class ViewModel {

    var items: [ItemEntity] = [
        ItemEntity(title: "Task 1", completedDate: "11.12.2022", completed: false),
        ItemEntity(title: "Task 2", completedDate: "07.11.2022", completed: false),
        ItemEntity(title: "Task 3", completedDate: nil, completed: true)
    ]

    func addItem(task string: String, completedDate: String = "", isCompleted: Bool = false) {
        items.append(ItemEntity(title: string, completedDate: completedDate, completed: isCompleted))
    }

    func removeItem(at indexPath: IndexPath) {
        items.remove(at: indexPath.row)
    }
}
