//
//  Medication+Convenience.swift
//  MedicationManager
//
//  Created by River McCaine on 1/18/21.
//

import CoreData
    
extension Medication {
    
    @discardableResult convenience init(name: String, timeOfDay: Date, id: String = UUID().uuidString, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.timeOfDay = timeOfDay
        self.id = id
    }
    
    func wasTakenToday() -> Bool {
        guard let _ = (takenDates as? Set<TakenDate>)?.first(where: { (takenDate) -> Bool in
            guard let date = takenDate.date else { return false }
            return Calendar.current.isDate(date, inSameDayAs: Date())
        }) else { return false }
        
        return true
    }
} // End of extension
