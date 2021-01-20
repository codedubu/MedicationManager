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
    @IBOutlet weak var moodSurveyButton: UIButton!
    
    
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
    
    
    @IBAction func moodSurveyButtonTapped(_ sender: UIButton) {
        guard let moodSurveyVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "moodSurveyViewController") as? MoodSurveyViewController else { return }
        
        moodSurveyVC.modalPresentationStyle = .fullScreen
        moodSurveyVC.delegate = self
        
        present(moodSurveyVC, animated: true, completion: nil)
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let medToDelete = MedicationController.shared.sections[indexPath.section][indexPath.row]
            MedicationController.shared.deleteMedication(medication: medToDelete)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
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

extension MedicationListViewController: MoodSurveyViewControllerDelegate {
    func emojiSelected(emoji: String) {
        moodSurveyButton.setTitle(emoji, for: .normal)
    }
        
//
//                if emoji == "😝" {
//
//                } else if emoji == "🤨" {
//                    print("hmmm.")
//                } else {
//                    print("naw son...")
//                }
    
    
    
}
