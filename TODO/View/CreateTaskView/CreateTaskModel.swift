//
//  CreateTaskModel.swift
//  todo
//
//  Created by Иван Тарасенко on 08.11.2022.
//

import UIKit

protocol TaskModelProtocol {
    func convertDateFormat(date: UIDatePicker) -> String
}

private struct KeysDefaults {
    static let keyData = "date"
}

final class CreateTaskModel: TaskModelProtocol {

    func convertDateFormat(date: UIDatePicker) -> String {
        
        // Create date formatter
        let dateFormatter: DateFormatter = DateFormatter()
        // Set date format
        dateFormatter.dateFormat = "EEEE, d MMM, yyyy hh:mm"
        // Apply date format
        let selectedDate: String = dateFormatter.string(from: date.date)

        return selectedDate
    }
}
