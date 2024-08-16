import UIKit
import SnapKit
import PhoneNumberKit
import Swinject
import DesignSystem

class CreateContactViewController: UIViewController {

    enum Row: Int, CaseIterable {
        case fullName
        case phone
    }

    private weak var tableView: UITableView!

    var viewModel: CreateContactViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureTableView()
        updateUI()

        // Add this line
        extendedLayoutIncludesOpaqueBars = true
    }

    private func setupUI() {
        view.backgroundColor = .background
        navigationItem.largeTitleDisplayMode = .never

        // Set title based on mode
        title = viewModel.mode == .create ? CreateContactStrings.createContactTitle.rawValue : CreateContactStrings.editContactTitle.rawValue

        // Add Create/Save button
        let rightButtonTitle = viewModel.mode == .create ? CreateContactStrings.create.rawValue : CreateContactStrings.save.rawValue
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: rightButtonTitle, style: .done, target: self, action: #selector(createOrSaveTapped))

        setupTableView()
    }

    private func setupTableView() {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .background
        tableView.contentInsetAdjustmentBehavior = .never
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)

            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }

        self.tableView = tableView
    }

    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(ProfileTextFieldCell.self, forCellReuseIdentifier: ProfileTextFieldCell.identifier)
        tableView.register(ProfilePhoneNumberCell.self, forCellReuseIdentifier: ProfilePhoneNumberCell.identifier)
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
    }

    private func updateUI() {
        if case .edit(let contact) = viewModel.mode {
            viewModel.fullName = contact.name
            viewModel.phoneNumber = contact.phoneNumber
        }
        tableView.reloadData()
    }

    @objc private func createOrSaveTapped() {
        viewModel.createTapped()
    }
}

extension CreateContactViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Row.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = Row(rawValue: indexPath.row) else {
            return UITableViewCell()
        }

        switch row {
        case .fullName:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTextFieldCell.identifier, for: indexPath) as? ProfileTextFieldCell else {
                return UITableViewCell()
            }
            cell.configure(with: .init(
                placeholder: CreateContactStrings.enterFullName.rawValue,
                header: "FULL NAME",
                text: viewModel.fullName
            ))
            cell.textField.delegate = self
            return cell
        case .phone:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfilePhoneNumberCell.identifier, for: indexPath) as? ProfilePhoneNumberCell else {
                return UITableViewCell()
            }
            cell.configure(with: .init(
                placeholder: CreateContactStrings.enterPhoneNumber.rawValue,
                header: "PHONE",
                text: viewModel.phoneNumber
            ))
            cell.textField.addTarget(self, action: #selector(phoneNumberDidChange(_:)), for: .editingChanged)
            return cell
        }
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let row = Row(rawValue: indexPath.row) else { return 0 }

        switch row {
        case .fullName, .phone: return 96
        }
    }
}

extension CreateContactViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let indexPath = tableView.indexPathForRow(at: textField.convert(textField.bounds.origin, to: tableView)),
              let row = Row(rawValue: indexPath.row) else { return }

        switch row {
        case .fullName:
            viewModel.fullName = textField.text ?? ""
        case .phone:
            // This is handled by phoneNumberDidChange(_:)
            break
        }
    }

    @objc private func phoneNumberDidChange(_ textField: PhoneNumberTextField) {
        viewModel.phoneNumber = textField.text ?? ""
    }
}
