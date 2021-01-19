//
//  MedicationListViewController.swift
//  MedicationManager
//
//  Created by River McCaine on 1/18/21.
//

import UIKit

class MedicationListViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MedicationController.shared.fetchMedications()
        tableView.reloadData()
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMedicationDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? MedicationDetailViewController else { return }
            let medication = MedicationController.shared.sections[indexPath.section][indexPath.row]
            destination.medication = medication
        }
    }
} // End of class

extension MedicationListViewController: UITableViewDelegate {
    // Use tomorrow
} // End of extension

extension MedicationListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return MedicationController.shared.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MedicationController.shared.sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "medicationCell", for: indexPath) as? MedicationTableViewCell else { return UITableViewCell() }
        
        let medication = MedicationController.shared.sections[indexPath.section][indexPath.row]
        
        cell.delegate = self
        cell.configure(with: medication)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Not Taken"
        } else {
            return "Taken"
        }
    }
    
    
} // End of extension

extension MedicationListViewController: MedicationTakenDelegate {
    func medicationWasTakenTapped(wasTaken: Bool, medication: Medication) {
        MedicationController.shared.updateMedicationTakenStatus(medication: medication, wasTaken: wasTaken)
        tableView.reloadData()
    }
    // tell my model controller to mark a medication as taken or not
} // End of extension
