//
//  MedicationDetailViewController.swift
//  MedicationManager
//
//  Created by River McCaine on 1/18/21.
//

import UIKit

class MedicationDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var medicationNameTextField: UITextField!
    @IBOutlet weak var medicationDueDatePicker: UIDatePicker!
    
    // MARK: - Properties
    // Landing pad for a medication object. 
    var medication: Medication?
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = medicationNameTextField.text, !name.isEmpty else { return }
        
        if let medication = medication {
            MedicationController.shared.updateMedication(medication: medication, name: name, timeOfDay: medicationDueDatePicker.date)
        } else {
            MedicationController.shared.createMedication(name: name, timeOfDay: medicationDueDatePicker.date)
        }
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helper Functions
    func updateViews() {
        guard let medication = medication else { return }
        medicationNameTextField.text = medication.name
        medicationDueDatePicker.date = medication.timeOfDay ?? Date()
    }
}
