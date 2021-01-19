//
//  MedicationTableViewCell.swift
//  MedicationManager
//
//  Created by River McCaine on 1/18/21.
//

import UIKit

protocol MedicationTakenDelegate: AnyObject {
    func medicationWasTakenTapped(wasTaken: Bool, medication: Medication)
}

class MedicationTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var medicationNameLabel: UILabel!
    @IBOutlet weak var medicationTimeLabel: UILabel!
    @IBOutlet weak var hasTakenButton: UIButton!
    
    // MARK: - Properties
    var medication: Medication?
    var wasTakenToday: Bool = false
    
    // If nobody volunteers as tribute to be the delegate, then this value will be nil.
    weak var delegate: MedicationTakenDelegate?
    
    // MARK: - Actions
    @IBAction func hasTakenButtonTapped(_ sender: Any) {
        guard let medication = medication else { return }
        wasTakenToday.toggle()
        delegate?.medicationWasTakenTapped(wasTaken: wasTakenToday, medication: medication)
        
    }
    
    // MARK: - Helper Functions
    func configure(with medication: Medication) {
        self.medication = medication
        wasTakenToday = medication.wasTakenToday() // true or false
        
        medicationNameLabel.text = medication.name
        medicationTimeLabel.text = DateFormatter.medicationTime.string(from: medication.timeOfDay ?? Date())
        
        // Ternary Operator ~> conditon ? if true : if false
        let image = wasTakenToday ? UIImage(systemName: "checkmark.square") : UIImage(systemName: "square")
        hasTakenButton.setImage(image, for: .normal)
        hasTakenButton.tintColor = .black
    }
} // Extension of class
