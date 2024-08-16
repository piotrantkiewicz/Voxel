import UIKit
import SnapKit

class ContactInfoViewController: UIViewController {
    private weak var tableView: UITableView!

    var viewModel: ContactInfoViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureTableView()
        updateUI()
    }

    private func setupUI() {
        view.backgroundColor = .background

        configureNavigationItem()
        setupTableView()
    }

    private func configureNavigationItem() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(editTapped))

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }

    private func setupTableView() {
        let tableView = UITableView()
        tableView.backgroundColor = .background
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(getStatusBarHeight())
            make.bottom.equalToSuperview()
        }

        self.tableView = tableView
    }

    private func getStatusBarHeight() -> CGFloat {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        else { return 0 }

        return windowScene.statusBarManager?.statusBarFrame.height ?? 0
    }

    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(ContactInfoCell.self, forCellReuseIdentifier: ContactInfoCell.identifier)
    }

    private func updateUI() {
        tableView.reloadData()
    }

    @objc private func editTapped() {
        viewModel.editContact()
    }
}

extension ContactInfoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ContactInfoCell.identifier, for: indexPath) as? ContactInfoCell
        else { return UITableViewCell() }

        cell.configure(with: viewModel.contact)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
