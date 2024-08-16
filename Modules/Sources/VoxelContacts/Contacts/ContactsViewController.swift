import UIKit
import SnapKit
import DesignSystem

enum ContactsStrings: String {
    case search = "Search"
    case contactsNotFound = "Contacts not found"
    case contactsSection = "CONTACTS"
}

class ContactsViewController: UIViewController {

    private weak var tableView: UITableView!

    var viewModel: ContactsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()

        configureTableView()
        loadContacts()
    }

    private func configureTableView() {
        tableView.register(ContactCell.self, forCellReuseIdentifier: "ContactCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 72, bottom: 0, right: 16)
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionHeaderTopPadding = 0
        tableView.backgroundColor = .background
    }

    private func loadContacts() {
        Task {
            await viewModel.fetch()
            await MainActor.run {
                self.tableView.reloadData()
            }
        }
    }
}

extension ContactsViewController {

    private func setupUI() {
        setupNavigationTitle()
        setupTableView()
    }

    private func setupNavigationTitle() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .font: UIFont.title
        ]
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)

        let addBtn = UIBarButtonItem(image: UIImage(resource: .addBtn), style: .plain, target: self, action: #selector(didTapAddContact))
        navigationItem.rightBarButtonItem = addBtn
    }

    @objc
    private func didTapAddContact() {
        viewModel.didTapAddContact()
    }

    private func setupTableView() {
        let tableView = UITableView()
        tableView.backgroundColor = .background
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        self.tableView = tableView
    }
}

extension ContactsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.sectionTitles.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = viewModel.sectionTitles[section]
        return viewModel.contacts[key]?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactCell else {
            return UITableViewCell()
        }

        let key = viewModel.sectionTitles[indexPath.section]
        let contact = viewModel.contacts[key]![indexPath.row]

        cell.configure(with: contact)
        configureCellCorners(for: cell, at: indexPath)

        return cell
    }


    private func configureCellCorners(for cell: ContactCell, at indexPath: IndexPath) {
        let isFirstCell = indexPath.row == 0
        let isLastCell = indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1

        if isFirstCell && isLastCell {
            cell.configureCellCorners(corners: .allCorners)
        } else if isFirstCell {
            cell.configureCellCorners(corners: [.topLeft, .topRight])
        } else if isLastCell {
            cell.configureCellCorners(corners: [.bottomLeft, .bottomRight])
        } else {
            cell.configureCellCorners(corners: [])
        }

        // Hide separator for last cell in section
        cell.separatorInset = isLastCell ? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude) : tableView.separatorInset
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear

        let label = UILabel()
        label.font = .title3
        label.textColor = .secondaryLabel
        label.text = String(viewModel.sectionTitles[section])

        headerView.addSubview(label)
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-8)
        }

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let key = viewModel.sectionTitles[indexPath.section]
        let contact = viewModel.contacts[key]![indexPath.row]

        viewModel.didSelectContact(contact)
    }
}
