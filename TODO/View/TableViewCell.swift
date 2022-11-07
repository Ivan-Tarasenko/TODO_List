//
//  TableViewCell.swift
//  todo
//
//  Created by Иван Тарасенко on 06.11.2022.
//

import UIKit

final class Cell: UITableViewCell {

    static var identifier: String {
        return String(describing: self)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

            // Setting up the cell
   private func setupCell() {
//        layer.borderWidth = 1
//        layer.borderColor = UIColor.black.cgColor
//        layer.cornerRadius = 4
//        backgroundColor = .systemGray6
    }
}
