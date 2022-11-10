//
//  CreateTaskModel.swift
//  todo
//
//  Created by Иван Тарасенко on 08.11.2022.
//

import UIKit

private struct KeysDefaults {
    static let keyData = "date"
}

final class CreateTaskModel {

    func convertDateFormat(date: UIDatePicker) -> String {
        
        // Create date formatter
        let dateFormatter: DateFormatter = DateFormatter()
        // Set date format
        dateFormatter.dateFormat = "EEEE, d MMM, yyyy hh:mm"
        // Apply date format
        let selectedDate: String = dateFormatter.string(from: date.date)

        return selectedDate
    }

    // Save date completed task
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
