//
//  MedicationTableViewCell.swift
//  MedicationManager
//
//  Created by River McCaine on 1/18/21.
//

import UIKit

class MedicationTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var medicationNameLabel: UILabel!
    @IBOutlet weak var medicationTimeLabel: UILabel!
    @IBOutlet weak var hasTakenButton: UIButton!
    
    // MARK: - Actions
    @IBAction func hasTakenButtonTapped(_ sender: Any) {
        print("hasTakenButton tapped.")
    }
    
    // MARK: - Helper Functions
    // prob update the checkmark
    func updateViews(medication: Medication) {
        medicationNameLabel.text = medication.name
        medicationTimeLabel.text = DateFormatter.medicationTime.string(from: medication.timeOfDay ?? Date())
    }
} // Extension of class
