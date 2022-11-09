//
//  TableViewDelegate.swift
//  todo
//
//  Created by Иван Тарасенко on 07.11.2022.
//

import UIKit

class TableViewDelegate: NSObject, UITableViewDelegate {

    let model = ViewModel()
    var editButtonAction: ((Int) -> Void)?
    var removeButtonAction: ((Int) -> Void)?

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    // Created and added a header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: tableView.frame.width, height: 50))
        label.text = "Tasks"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        headerView.addSubview(label)
        return headerView
    }

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let editAction = UIContextualAction(style: .normal, title: "Edit") { _, _, _ in
            self.editButtonAction?(indexPath.row)
        }

        editAction.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [editAction])
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { _, _, _ in
            self.removeButtonAction?(indexPath.row)
        }

        deleteAction.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)  // The method that marks the cell selection

        if model.changeState(at: indexPath.row) == true {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
    }
}
