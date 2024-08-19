import Foundation
import Swinject
import PhoneNumberKit

public class CreateContactViewModel {
    private let container: Container
    private let coordinator: CreateContactCoordinator
    private let phoneNumberKit = PhoneNumberKit()
    private var repository: ContactsRepository {
        container.resolve(ContactsRepository.self)!
    }

    let mode: CreateContactMode
    var fullName: String = ""
    var phoneNumber: String = ""
    
    var isContactValid: Bool {
        isFullNameValid && isPhoneNumberValid
    }
    
    private var isFullNameValid: Bool {
        fullName.trimmingCharacters(in: .whitespacesAndNewlines).count > 1
    }
    
    private var isPhoneNumberValid: Bool {
        do {
            _ = try phoneNumberKit.parse(phoneNumber)
            return true
        } catch {
            return false
        }
    }

    init(container: Container, coordinator: CreateContactCoordinator, mode: CreateContactMode) {
        self.container = container
        self.coordinator = coordinator
        self.mode = mode
    }

    func createTapped() async throws {
        switch mode {
        case .create:
            try await createContact()
        case .edit(let contact):
            try await updateContact(contact)
        }
    }

    private func createContact() async throws {
        
        let formattedPhoneNumber = try getFormattedPhoneNumber()
        
        try await repository.addContact(
            withPhoneNumber: formattedPhoneNumber,
            fullName: fullName
        )
        
        await MainActor.run {
            coordinator.dismiss()
        }
    }

    private func getFormattedPhoneNumber() throws -> String {
        let phoneNumber = try phoneNumberKit.parse(phoneNumber)
        return phoneNumberKit.format(phoneNumber, toType: .e164)
    }
    
    private func updateContact(_ contact: Contact) async throws {
        
        await MainActor.run {
            coordinator.dismiss()
        }
    }
}











