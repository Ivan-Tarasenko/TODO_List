//
//  NavigationController.swift
//  todo
//
//  Created by Иван Тарасенко on 07.11.2022.
//

import UIKit

class MyNavigationController: UINavigationController {



    // Кнопка с изображением
    let img = UIBarButtonItem(image: .checkmark, style: .plain, target: self, action: #selector(closeTVC))

    // Кнопка с системной иконкой
    let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(closeTVC))

    // Кнопка с текстом
    let play = UIBarButtonItem(title: "Play", style: .plain, target: self, action: #selector(closeTVC))

    @objc func closeTVC() {
    dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.backgroundColor = .systemGray6
        navigationItem.leftBarButtonItems = [img, add, play]

    }

}


