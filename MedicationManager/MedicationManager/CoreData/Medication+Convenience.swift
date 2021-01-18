//
//  Medication+Convenience.swift
//  MedicationManager
//
//  Created by River McCaine on 1/18/21.
//

import CoreData
    
extension Medication {
    
    @discardableResult convenience init(name: String, timeOfDay: Date, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.timeOfDay = timeOfDay
    }
} // End of extension
