//
//  EditContact.swift
//  Contact(Task)
//
//  Created by Сергей Анпилогов on 13.10.2023.
//

import SwiftUI

struct DetailContact: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @State private var isShowingEditView = false

    var contact: FetchedResults<Contacts>.Element

    @ObservedObject var contactData = ContactData()

    var body: some View {
        Form {
            Section() {
                Text(contact.firstName ?? "")
                Text(contact.lastName ?? "")
                Text(contact.email ?? "")
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    contactData.firstName = contact.firstName ?? ""
                    contactData.lastName = contact.lastName ?? ""
                    contactData.email = contact.email ?? ""
                    isShowingEditView.toggle()
                }
            }
        }
        .sheet(isPresented: $isShowingEditView) {
            EditContact(contact: contact, updatedFirstName: $contactData.firstName, updatedLastName: $contactData.lastName, updatedEmail: $contactData.email)
        }
    }
}
