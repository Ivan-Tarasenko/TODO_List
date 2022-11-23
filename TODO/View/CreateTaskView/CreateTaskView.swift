//
//  CreateTaskView.swift
//  todo
//
//  Created by Иван Тарасенко on 07.11.2022.
//

import UIKit

final class CreateTaskView: UIView {

    var doneAction: ((String, String) -> Void)?
    var model: TaskModelProtocol!
    var saveDate: DataProtorol!

    let doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Create task"
        label.textColor = .darkText
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let textField: UITextField = {
        let field = UITextField()
        field.backgroundColor = .white
        field.borderStyle = .roundedRect
        field.placeholder = "Enter task"
        field.becomeFirstResponder()
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    let completeLabel: UILabel = {
        let label = UILabel()
        label.text = "Complete before:"
        label.textColor = .darkText
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.timeZone = .autoupdatingCurrent
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()

    override init(frame: CGRect) {
        super.init(frame: CGRect(origin: .zero, size: CGSize(width: 230, height: 280)))
        saveDate = SaveData()
        model = CreateTaskModel()
        setupView()
        makeCondtraints()
        addTargets()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = .systemGray5
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        layer.cornerRadius = 10
        addSubview(doneButton)
        addSubview(cancelButton)
        addSubview(titleLabel)
        addSubview(textField)
        addSubview(completeLabel)
        addSubview(datePicker)

    }

    private func makeCondtraints() {
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            doneButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),

            cancelButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            cancelButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),

            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: doneButton.topAnchor, constant: 50),

            textField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            textField.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 30),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),

            completeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            completeLabel.topAnchor.constraint(equalTo: textField.topAnchor, constant: 75),

            datePicker.topAnchor.constraint(equalTo: completeLabel.topAnchor, constant: textField.frame.height + 36)
        ])
    }

    func addTargets() {
        doneButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        datePicker.addTarget(self, action: #selector(datePickerPressed(_:)), for: .valueChanged)

    }
}

@objc extension CreateTaskView {

    func doneButtonPressed() {
        guard !textField.text!.isEmpty else { return }
        guard let titleTask = textField.text else { return }
        doneAction?(saveDate.data ?? "", titleTask)
        saveDate.data?.removeAll()
        textField.text?.removeAll()
        animationHidden()
    }

    func cancelButtonPressed() {
        animationHidden()
    }

    func datePickerPressed(_ sender: UIDatePicker) {
        saveDate.data = model.convertDateFormat(date: sender)
    }

    func animationHidden() {
        UIView.animate(withDuration: 0.25) {
            self.transform = self.transform.scaledBy(x: 0.001, y: 0.001)
        } completion: { _ in
            self.transform = self.transform.scaledBy(x: 1000, y: 1000)
            self.removeFromSuperview()
        }
    }
}
