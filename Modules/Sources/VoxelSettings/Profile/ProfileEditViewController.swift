import UIKit
import SnapKit

public final class ProfileEditViewController: UIViewController {
    
    private weak var tableView: UITableView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(ProfileEditPictureCell.self, forCellReuseIdentifier: ProfileEditPictureCell.identifier)
    }
}

extension ProfileEditViewController {
    private func setupUI() {
        view.backgroundColor = .background
        configureNavigationItem()
        
        setupTableView()
    }
    
    private func configureNavigationItem() {
        navigationItem.largeTitleDisplayMode = .never
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
}

extension ProfileEditViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileEditPictureCell.identifier, for: indexPath) as? ProfileEditPictureCell
        else { return UITableViewCell() }
        
        return cell
    }
}
