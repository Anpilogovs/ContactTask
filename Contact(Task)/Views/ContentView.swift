//
//  Views.swift
//  Contact(Task)
//
//  Created by Сергей Анпилогов on 13.10.2023.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var contact: FetchedResults<Contacts>

    @State private var showingAddView = false

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {

                List {
                    ForEach(contact) { contact in
                        NavigationLink(destination: DetailContact(contact: contact), label: {

                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text("\(contact.firstName ?? "") \(contact.lastName ?? "")")
                                        .bold()
                                }
                                Spacer()
                            }

                        }
                        )
                    }
                    .onDelete(perform: deleteContact)
                }
                .listStyle(.plain)
            }
            .navigationTitle("Contacts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddView.toggle()
                    } label: {
                        Label("Add Contact", systemImage: "plus.circle")
                    }
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddContact()
            }
        }
        .navigationViewStyle(.stack)
    }

    private func deleteContact(offsets: IndexSet) {
        withAnimation {
            offsets.map { contact[$0] }
                .forEach(managedObjContext.delete)

              DataController().save(context: managedObjContext)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
