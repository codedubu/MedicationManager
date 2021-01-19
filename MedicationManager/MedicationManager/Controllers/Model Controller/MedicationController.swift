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
    var sections: [[Medication]] { [notTakenMeds, takenMeds] }
    
    var notTakenMeds: [Medication] = []
    var takenMeds: [Medication] = []
    // ints [1,2,3,4]
    // otherInts [5,6,7,8]
    
    // var arrays [ [1,2,3,4] , [5,6,7,8] ]
    // arrays[0][2] == 3
    // arrays [1][3] == 8
    // [ints, otherInts]
    
    
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
        notTakenMeds.append(newMed)
        CoreDataStack.saveContext()
    }
    
    // Read
    func fetchMedications() {
        let medications = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
        //$0 is medications. Works like a For In loop.
        takenMeds = medications.filter { $0.wasTakenToday() }
        notTakenMeds = medications.filter({ (med) -> Bool in
            //If med was NOT taken today, then put it into notTakenMeds.
            return !med.wasTakenToday()
        })
    }
    
    // Update
    func updateMedication(medication: Medication, name: String, timeOfDay: Date) {
        medication.name = name
        medication.timeOfDay = timeOfDay
        CoreDataStack.saveContext()
    }
    
    // notTaken = [vc, vd, ve]
    // taken = [iron, zinc, hgw]
    
    func updateMedicationTakenStatus(medication: Medication, wasTaken: Bool) {
        if wasTaken {
            TakenDate(date: Date(), medication: medication)
            if let index = notTakenMeds.firstIndex(of: medication) {
                notTakenMeds.remove(at: index)
                takenMeds.append(medication)
            }
        } else {
            // Create a mutable form so that we can remove and place objects into the set. 
            let mutableTakenDates = medication.mutableSetValue(forKey: "takenDates")
            
            if let takenDate = (mutableTakenDates as? Set<TakenDate>)?.first(where: { (takenDate) -> Bool in
                guard let date = takenDate.date else { return false }
                return Calendar.current.isDate(date, inSameDayAs: Date())
            }) {
                mutableTakenDates.remove(takenDate)
                if let index = takenMeds.firstIndex(of: medication) {
                    takenMeds.remove(at: index)
                    notTakenMeds.append(medication)
                }
            }
        }
        CoreDataStack.saveContext()
    }
    // Delete
    func deleteMedication() {
        // HANDLE THIS TOMORROW
        
    }
} // End of class
