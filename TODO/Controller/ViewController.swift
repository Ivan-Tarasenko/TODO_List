//
//  ViewController.swift
//  todo
//
//  Created by Иван Тарасенко on 06.11.2022.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {

    var model = ViewModel()

    var customDataSource = TableViewDataSource()
    private let customDelegate = TableViewDelegate()
    private let tableView = CustomTableView()
    private let createTaskView = CreateTaskView()
    private let searchController = UISearchController()

    let saveDate = SaveData()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        setupSearchController()
        setupNavigationBar()
        bind()
//        doneButtonPressed()
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
    }

    func bind() {
        createTaskView.doneAction = { [weak self] date, title in
            guard let self else { return }
            self.model.addItem(task: title, completedDate: date)
            self.tableView.reloadData()

        }
    }
}

// MARK: - Actions Nav Bar
// Actions of navigation panel buttons
@objc extension ViewController {

    func addButtonPressed() {
        createTaskView.isHidden = false

    }

    func editButtonPressed() {
        print("edit")
    }

    func sortButtonPressed() {
        print("sort")
    }
}

// MARK: - Private Extension
private extension ViewController {

    func setupView() {
        view.addSubview(tableView)
        view.addSubview(createTaskView)
        customDataSource.model = model
        createTaskView.center = view.center
        createTaskView.isHidden = true
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
