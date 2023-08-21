//
//  Transaction+CoreDataProperties.swift
//  ReDebt_v2
//
//  Created by Raja Monica on 21/08/23.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var date: Date?
    @NSManaged public var nominal: Double
    @NSManaged public var note: String?
    @NSManaged public var person: Person?
    
    public var unwrappedNote: String {
        note ?? "Unknown note"
    }
    
    public var unwrappedNominal: Double {
        nominal
    }
    
    public var unwrappedDate: Date {
        date ?? Date()
    }

}

extension Transaction : Identifiable {

}
