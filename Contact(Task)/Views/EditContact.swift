//
//  EditContact.swift
//  Contact(Task)
//
//  Created by Сергей Анпилогов on 13.10.2023.
//

import SwiftUI

struct EditContact: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss

    var contact: FetchedResults<Contacts>.Element

    @Binding var updatedFirstName: String
    @Binding var updatedLastName: String
    @Binding var updatedEmail: String

    var body: some View {
        Form {
            Section() {
                TextField("First Name", text: $updatedFirstName)
                TextField("Last Name", text: $updatedLastName)
                TextField("Email", text: $updatedEmail)
            }

            HStack {
                Spacer()

                Button("Submit") {
                    updateContact()
                    dismiss()
                }
                Spacer()
            }
        }
    }

    private func updateContact() {
        DataController().updateContact(
            contact: contact,
            updatedFirstName: updatedFirstName,
            updatedLastName: updatedLastName,
            updatedEmail: updatedEmail,
            context: managedObjContext)
    }
}
