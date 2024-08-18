import Foundation
import XCTest
import Swinject
@testable import VoxelContacts

class ContactsCoordinatorMock: ContactsCoordinator {
    func presentAddContact() {}
    
    func showContactInfo(for contact: Contact) {}
    
    func start() {}
}

final class ContactsViewModelTests: XCTestCase {
    
    private var viewModel: ContactsViewModel!
    private var container: Container!
    private var coordinator: ContactsCoordinatorMock!
    
    override func setUp() {
        super.setUp()
        container = Container()
        container.register(ContactsRepository.self) { _ in
            ContactsRepositoryFake()
        }
        coordinator = ContactsCoordinatorMock()
        viewModel = ContactsViewModel(
            container: container,
            coordinator: coordinator
        )
    }
    
    func test_whenSearch_thenOnlyOneSectionShown() {
        //given
        let query = "a"
        //when
        viewModel.search(with: query)
        //then
        XCTAssertEqual(viewModel.sectionTitles.count, 1)
        XCTAssertEqual(viewModel.sectionTitles[0], ContactsStrings.contactsSection.rawValue)
    }
    
    func test_whenSearch_thenShouldFilterResults() async throws {
        //given
        let query = "wa"
        try await viewModel.fetch()
        //when
        viewModel.search(with: query)
        //then
        XCTAssertEqual(viewModel.contacts.keys.count, 1)
        XCTAssertEqual(viewModel.contacts[ContactsStrings.contactsSection.rawValue]!.count, 2)
        XCTAssertEqual(viewModel.contacts[ContactsStrings.contactsSection.rawValue]!.map { $0.name }, [
            "Arnold Watson", "Bernard Edwards"
        ])
    }
    
    func test_whenSearchByPhoneNumber_thenShouldFilterResults() async throws {
        //given
        let query = "0204"
        try await viewModel.fetch()
        //when
        viewModel.search(with: query)
        //then
        XCTAssertEqual(viewModel.contacts.keys.count, 1)
        XCTAssertEqual(viewModel.contacts[ContactsStrings.contactsSection.rawValue]!.count, 1)
        XCTAssertEqual(viewModel.contacts[ContactsStrings.contactsSection.rawValue]!.map { $0.phoneNumber }, [
            "+1 202-555-0204"
        ])
    }
    
    func test_whenSearchAndCancel_thenShouldShowAllContacts() async throws {
        //given
        try await viewModel.fetch()
        let query = "wa"
        viewModel.search(with: query)
        //when
        viewModel.search(with: "")
        //then
        XCTAssertEqual(viewModel.contacts.keys.count, 2)
        XCTAssertEqual(viewModel.contacts["A"]!.count, 5)
        XCTAssertEqual(viewModel.contacts["B"]!.count, 4)
    }
}






