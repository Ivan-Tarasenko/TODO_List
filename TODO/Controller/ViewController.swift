//
//  ViewController.swift
//  todo
//
//  Created by Иван Тарасенко on 06.11.2022.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {

    let customDataSource = TableViewDataSource()
    let customDelegate = TableViewDelegate()

    private let tableView = CustomTableView()
    private let searchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        setupSearchController()
        setupNavigationBar()
    }

    func setupNavigationBar() {
        let add = UIBarButtonItem(
            image: UIImage(systemName: "rectangle.and.pencil.and.ellipsis"),
            style: .plain,
            target: self,
            action: #selector(addButtonPressed)
        )

        let edit = UIBarButtonItem(
            image: UIImage(systemName: "highlighter"),
            style: .plain,
            target: self,
            action: #selector(editButtonPressed)
        )

        let sort = UIBarButtonItem(
            image: UIImage(systemName: "arrow.up"),
            style: .plain,
            target: self,
            action: #selector(sortButtonPressed)
        )

        navigationItem.rightBarButtonItems = [add, edit, sort]
        navigationController?.navigationBar.backgroundColor = .systemGray6
        self.definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}

@objc extension ViewController {

    func addButtonPressed() {
        print("add")
    }

    func editButtonPressed() {
        print("edit")
    }

    func sortButtonPressed() {
        print("sort")
    }
}

private extension ViewController {

    func setupView() {
        view.addSubview(tableView)
//        title = "ToDo List"
    }

    func setupSearchController() {
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search task"
        navigationItem.searchController = searchController
    }

    // Registration of a custom cell and setting tableView
    func setupTableView() {
        tableView.dataSource = customDataSource
        tableView.delegate = customDelegate
        tableView.frame = view.frame
        tableView.register(Cell.self, forCellReuseIdentifier: Cell.identifier)
    }
}
