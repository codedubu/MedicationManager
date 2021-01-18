//
//  DateFormatterExtension.swift
//  MedicationManager
//
//  Created by River McCaine on 1/18/21.
//

import Foundation

extension DateFormatter {
    
    static let medicationTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
    
    
} // End of extension
