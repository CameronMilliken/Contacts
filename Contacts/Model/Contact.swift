//
//  Contact.swift
//  Contacts
//
//  Created by Cameron Milliken on 2/28/19.
//  Copyright © 2019 Cameron Milliken. All rights reserved.
//

import Foundation
import CloudKit

class Contact {
    
    // Properties
    var name: String
    var phoneNumber: Int?
    var email: String?
    
    // CloudKit Access
    let ckRecordId: CKRecord.ID
    
    enum ContactKeys {
        static let recordKey = "Contact"
        static let nameKey = "name"
        static let phoneNumberKey = "phoneNumber"
        static let emailKey = "email"
    }
    
    // Initializer
    init(name: String, phoneNumber: Int, email: String, ckRecordId: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.name = name
        self.phoneNumber = phoneNumber
        self.email = email
        self.ckRecordId = ckRecordId
    }
    
    convenience init?(ckRecord: CKRecord) {
        guard let name = ckRecord[ContactKeys.nameKey] as? String,
        let phoneNumber = ckRecord[ContactKeys.phoneNumberKey] as? Int,
        let email = ckRecord[ContactKeys.emailKey] as? String else {return nil}
        self.init(name: name, phoneNumber: phoneNumber, email: email, ckRecordId: ckRecord.recordID)
    }
    
} // End of class

// CKRecord Extension
extension CKRecord {
    convenience init(contact: Contact) {
        self.init(recordType: Contact.ContactKeys.recordKey, recordID: contact.ckRecordId)
        self.setValue(contact.name, forKey: Contact.ContactKeys.nameKey)
        self.setValue(contact.phoneNumber, forKey: Contact.ContactKeys.phoneNumberKey)
        self.setValue(contact.email, forKey: Contact.ContactKeys.emailKey)
    }
}

// Equatable
extension Contact: Equatable {
    static func == (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.email == rhs.email && lhs.phoneNumber == rhs.phoneNumber && lhs.name == rhs.name && lhs.ckRecordId == rhs.ckRecordId
    }
}
