//
//  MedicationController.swift
//  MedicationManager
//
//  Created by River McCaine on 1/18/21.
//

import CoreData

class MedicationController {
    // MARK: - Shared Instance
    static let shared = MedicationController()
    
    // MARK: - Sourth of Truth
    var medications: [Medication] = []
    
    // MARK: - Fetch Request
    private lazy var fetchRequest: NSFetchRequest<Medication> = {
       let request = NSFetchRequest<Medication>(entityName: "Medication")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    // MARK: - CRUD
    
    // Create
    func createMedication(name: String, timeOfDay: Date) {
        let newMed = Medication(name: name, timeOfDay: timeOfDay)
        CoreDataStack.saveContext()
    }
    
    // Read
    func fetchMedications() {
        self.medications = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
    }
    
    // Update
    func updateMedication(medication: Medication, name: String, timeOfDay: Date) {
        medication.name = name
        medication.timeOfDay = timeOfDay
        CoreDataStack.saveContext()
    }
    
    // Delete
    func deleteMedication() {
        // HANDLE THIS TOMORROW
        
    }
} // End of class
