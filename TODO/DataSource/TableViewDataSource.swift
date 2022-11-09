//
//  TableViewDataSource.swift
//  todo
//
//  Created by Иван Тарасенко on 06.11.2022.
//

import UIKit

final class TableViewDataSource: NSObject, UITableViewDataSource {

    var model = ViewModel()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cell.identifier, for: indexPath) as? Cell else { fatalError("Cell nil") }

        let currentItem = model.items[indexPath.row]
        cell.titleLabel.text = currentItem.title
        cell.subtitleLabel.text = currentItem.completedDate

        cell.accessoryType = currentItem.completed ? .checkmark : .none

        return cell
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("TEst")
    }
}
