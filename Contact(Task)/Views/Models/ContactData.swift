//
//  ContactData.swift
//  Contact(Task)
//
//  Created by Сергей Анпилогов on 13.10.2023.
//

import Foundation

class ContactData: ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
}
