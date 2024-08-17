import Foundation
import Swinject

public class CreateContactViewModel {
    private let container: Container
    private let coordinator: CreateContactCoordinator

    let mode: CreateContactMode
    var fullName: String = ""
    var phoneNumber: String = ""

    init(container: Container, coordinator: CreateContactCoordinator, mode: CreateContactMode) {
        self.container = container
        self.coordinator = coordinator
        self.mode = mode
    }

    func createTapped() {
        switch mode {
        case .create:
            createContact()
        case .edit(let contact):
            updateContact(contact)
        }
    }

    private func createContact() {
        // Here you would typically use a service to create a new contact
//        let newContact = Contact(name: fullName, image: nil, isOnline: false, firstLetter: fullName.first ?? "A", phoneNumber: phoneNumber)
        // Save the new contact (this would depend on your app's architecture)
        // For example:
        // contactService.saveContact(newContact)
        coordinator.dismiss()
    }

    private func updateContact(_ contact: Contact) {
        // Here you would typically use a service to update the existing contact
//        let updatedContact = Contact(name: fullName, image: contact.image, isOnline: contact.isOnline, firstLetter: fullName.first ?? "A", phoneNumber: phoneNumber)
        // Update the contact (this would depend on your app's architecture)
        // For example:
        // contactService.updateContact(updatedContact)
        coordinator.dismiss()
    }
}
