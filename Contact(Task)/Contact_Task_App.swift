//
//  Contact_Task_App.swift
//  Contact(Task)
//
//  Created by Сергей Анпилогов on 13.10.2023.
//

import SwiftUI

@main
struct Contact_Task_App: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)

        }
    }
}
