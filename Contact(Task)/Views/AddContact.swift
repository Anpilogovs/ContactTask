//
//  AddContact.swift
//  Contact(Task)
//
//  Created by Сергей Анпилогов on 13.10.2023.
//

import SwiftUI

struct AddContact: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss

    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""

    @State private var isDoneButtonTapped = false

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("First name", text: $firstName)
                    TextField("Last name", text: $lastName)
                    TextField("Email", text: $email)
                }
            }
            .navigationBarItems(leading: cancelButton ,trailing: doneButton)
        }
    }

    private var cancelButton: some View {
        Button {
            dismiss()
        } label: {
            Text("Cancel")
        }
    }

    private var doneButton: some View {
        Button("Done") {
            if isInputValid() {
                isDoneButtonTapped = true
            }
        }
        .disabled(!isInputValid())
        .alert(isPresented: $isDoneButtonTapped) {
            Alert(
                title: Text("Confirm"),
                message: Text("Are you sure you want to save this contact?"),
                primaryButton: .default(Text("Save")) {
                    saveContact()
                    dismiss()
                },
                secondaryButton: .cancel()
            )
        }
    }

    private func saveContact() {
        DataController().addContacts(
            fristName: firstName,
            lastName: lastName,
            email: email,
            context: managedObjectContext)
    }

    private func isInputValid() -> Bool {
        return !firstName.isEmpty || !lastName.isEmpty || !email.isEmpty
    }
}

struct AddContact_Previews: PreviewProvider {
    static var previews: some View {
       AddContact()
    }
}
