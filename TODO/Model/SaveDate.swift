//
//  SaveDate.swift
//  todo
//
//  Created by Иван Тарасенко on 08.11.2022.
//

import Foundation

protocol DataProtorol {
    var data: String? {get set}
}

private struct KeysDefaults {
    static let keyData = "date"
}

final class SaveData: DataProtorol {

    private let defaults = UserDefaults.standard

    var data: String? {
        get {
            return defaults.string(forKey: KeysDefaults.keyData)
        }
        set {
            if let data = newValue {
                defaults.set(data, forKey: KeysDefaults.keyData)
            }
        }
    }
}
