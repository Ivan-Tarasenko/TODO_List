//
//  ViewController.swift
//  todo
//
//  Created by Иван Тарасенко on 06.11.2022.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {

    var model: ViewModelProtocol!

    var customDataSource = TableViewDataSource()
    private let customDelegate = TableViewDelegate()
    private let tableView = CustomTableView()
    private let createTaskView = CreateTaskView()
    private let searchController = UISearchController()

    override func viewDidLoad() {
        super.viewDidLoad()
        model = ViewModel()
        setupView()
        setupTableView()
        setupSearchController()
        setupNavigationBar()
        addItem()
        editIem()
        removeItem()
        changeStatus()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        model?.search(searchText: searchText)
        tableView.reloadData()
    }

}

// MARK: - Operation on items
extension ViewController {
    func addItem() {
        createTaskView.doneAction = { [weak self] date, title in
            guard let self else { return }
            self.model?.addItem(task: title, completedDate: date, isCompleted: false)
            self.tableView.reloadData()
        }
    }

    func editIem() {
        customDelegate.editButtonAction = { [weak self] index in
            guard let self else { return }
            self.appearanceView()
            self.createTaskView.textField.text! = self.model?.items[index].title ?? ""

            self.createTaskView.doneAction = { [self] date, title in
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

    func changeStatus() {
        customDelegate.changeStatusAction = { [weak self] indexPath in
            guard let self else { return }
            if self.model.changeState(at: indexPath.row) == true {
                self.tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
                self.tableView.cellForRow(at: indexPath)?.backgroundColor = R.ColorCell.done
            } else {
                self.tableView.cellForRow(at: indexPath)?.accessoryType = .none
                self.tableView.cellForRow(at: indexPath)?.backgroundColor = R.ColorCell.notCompleted
            }
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
        appearanceView()
    }

    func editButtonPressed() {
        let editON = UIImage(systemName: "highlighter")
        let editOff = UIImage(systemName: "pencil.slash")
        let editButton = navigationItem.rightBarButtonItems![1]
        tableView.setEditing(model.isEdit, animated: true)

        editButton.image = model.isEdit ? editOff : editON

        model.isEdit.toggle()
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
        customDataSource.model = model as? ViewModel 
        createTaskView.center = view.center
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

    // Animation of the appearance of the view
    func transformScale(posinionKey: String, view: UIView) {
        let animation = CABasicAnimation(keyPath: posinionKey)
        animation.fromValue = 0.1
        animation.toValue = 1
        animation.duration = 0.15
        animation.repeatCount = 1
        view.layer.add(animation, forKey: posinionKey)
    }

    func appearanceView() {
        view.addSubview(createTaskView)
        createTaskView.textField.becomeFirstResponder()
        transformScale(posinionKey: "transform.scale.x", view: createTaskView)
        transformScale(posinionKey: "transform.scale.y", view: createTaskView)

    }
}
