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

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 23)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        makeConstraint()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

            // Setting up the cell
   private func setupCell() {
       addSubview(titleLabel)
       addSubview(subtitleLabel)
    }

    func makeConstraint() {

        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 30),
            subtitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5)
        ])
    }
}
