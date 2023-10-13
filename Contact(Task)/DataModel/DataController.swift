//
//  DataController.swift
//  Contact(Task)
//
//  Created by Сергей Анпилогов on 13.10.2023.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "ContactsModel")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Failed to load data in DataController \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved successfully. WUHU!!!")
        } catch {
            // Handle errors in our database
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func addContacts(fristName: String, lastName: String, email: String, context: NSManagedObjectContext) {
        let contacts = Contacts(context: context)
        contacts.id = UUID()
        contacts.date = Date()
        contacts.firstName = fristName
        contacts.lastName = lastName
        contacts.email = email
        
        save(context: context)
    }
    
    func editContact(contact: Contacts, firstName: String, lastName: String, email: String, context: NSManagedObjectContext) {
        contact.date = Date()
        contact.firstName = firstName
        contact.lastName = lastName
        contact.email = email
        
        save(context: context)
    }
    
    func updateContact(contact: Contacts, updatedFirstName: String, updatedLastName: String, updatedEmail: String, context: NSManagedObjectContext) {
           context.perform {
               contact.firstName = updatedFirstName
               contact.lastName = updatedLastName
               contact.email = updatedEmail
               contact.date = Date()
               
               self.save(context: context)
           }
       }
}
