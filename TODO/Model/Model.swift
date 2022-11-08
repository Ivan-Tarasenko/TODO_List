//
//  Model.swift
//  todo
//
//  Created by Иван Тарасенко on 06.11.2022.
//

import Foundation

class ItemEntity {

    var title: String
    var completedDate: String?
    var completed: Bool

    init(title: String, completedDate: String?, completed: Bool) {
        self.title = title
        self.completedDate = completedDate
        self.completed = completed
    }

}
