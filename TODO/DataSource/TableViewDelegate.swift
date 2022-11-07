//
//  TableViewDelegate.swift
//  todo
//
//  Created by Иван Тарасенко on 07.11.2022.
//

import UIKit

class TableViewDelegate: NSObject, UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: tableView.frame.width, height: 50))
        label.text = "Tasks"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        headerView.addSubview(label)
        return headerView
    }
}
