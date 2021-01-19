//
//  TakenDate+Convenience.swift
//  MedicationManager
//
//  Created by River McCaine on 1/19/21.
//

import CoreData

extension TakenDate {
    // Lets us create a TakenDate without capturing it
    // NSManagedObjectContext is a platform where you manage your objects
    @discardableResult convenience init(date: Date, medication: Medication, context: NSManagedObjectContext = CoreDataStack.context ) {
        // Allows the data to be saved in the right place.
        self.init(context:context)
        self.date = date
        self.medication = medication
    }
}
