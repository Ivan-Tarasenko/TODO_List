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
        addItem()
        editIem()
        removeItem()
    }
}

// MARK: - Operation on items
extension ViewController {
    func addItem() {
        createTaskView.doneAction = { [weak self] date, title in
            guard let self else { return }
            self.model.addItem(task: title, completedDate: date)
            self.tableView.reloadData()

        }
    }

    func editIem() {
        customDelegate.editButtonAction = { [weak self] index in
            guard let self else { return }
            self.createTaskView.isHidden = false
            self.createTaskView.textField.text! = self.model.items[index].title
            self.createTaskView.doneAction = {[weak self] date, title in
                guard let self else { return }
                self.model.editItem(at: index, edit: title, date: date)
                self.tableView.reloadData()
            }
        }
    }

    func removeItem() {
        customDelegate.removeButtonAction = { [weak self] index in
            guard let self else { return }
            self.model.removeItem(at: index)
            self.tableView.reloadData()
        }
    }
}

// MARK: - Setting Navigation Controller
extension ViewController {
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

        navigationItem.rightBarButtonItems = [add, edit]
        navigationItem.leftBarButtonItems = [sort]
        navigationController?.navigationBar.backgroundColor = .systemGray6
    }
}

// MARK: - Actions Nav Bar
// Actions of navigation panel buttons
@objc extension ViewController {

    func addButtonPressed() {
        createTaskView.isHidden = false

    }

    func editButtonPressed() {
        let editON = UIImage(systemName: "highlighter")
        let editOff = UIImage(systemName: "pencil.slash")
        let editButton = navigationItem.rightBarButtonItems![1]
        tableView.setEditing(!tableView.isEditing, animated: true)

        editButton.image = model.isEdit ? editOff : editON

        model.isEdit.toggle()
//        tableView.reloadData()
    }

    func sortButtonPressed() {
        let sortUp = UIImage(systemName: "arrow.up")
        let sortDown = UIImage(systemName: "arrow.down")
        let sortButton = navigationItem.leftBarButtonItems![0]

        sortButton.image = model.isSorted ? sortDown : sortUp

        model.isSorted.toggle()
        model.sortItemByTitle()
        tableView.reloadData()
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
        title = "ToDo List"
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
