import UIKit
import SnapKit

public final class ProfileEditViewController: UIViewController {
    
    enum Row: Int, CaseIterable {
        case profilePicture
        case fullName
        case description
        case logout
    }
    
    private weak var tableView: UITableView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureTableView()
        setupHideKeyboardGesture()
        subscribeToKeyboard()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.register(ProfileEditPictureCell.self, forCellReuseIdentifier: ProfileEditPictureCell.identifier)
        tableView.register(ProfileTextFieldCell.self, forCellReuseIdentifier: ProfileTextFieldCell.identifier)
        tableView.register(ButtonCell.self, forCellReuseIdentifier: ButtonCell.identifier)
    }
}

// MARK: Keyboard

extension ProfileEditViewController {
    private func setupHideKeyboardGesture() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard)
        )
        
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func subscribeToKeyboard() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let endFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        else { return }
        
        let isKeyboardHidden = endFrame.origin.y >= UIScreen.main.bounds.size.height
        
        let bottomMargin = isKeyboardHidden ? 0 : -endFrame.height - 16
        
        tableView.snp.updateConstraints { make in
            make.bottom.equalToSuperview().offset(bottomMargin)
        }
        
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
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
        
        let saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc
    private func didTapSave() {
        print("did save")
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
        Row.allCases.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let row = Row(rawValue: indexPath.row) else { return UITableViewCell() }
        
        switch row {
        case .profilePicture:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileEditPictureCell.identifier, for: indexPath) as? ProfileEditPictureCell
            else { return UITableViewCell() }
            
            cell.didTap = { [weak self] in
                self?.didTapProfilePicture()
            }
            
            return cell
            
        case .fullName, .description:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTextFieldCell.identifier, for: indexPath) as? ProfileTextFieldCell
            else { return UITableViewCell() }
            
            cell.configure(with: row == .fullName ? .fullName() : .description())
            
            return cell
        
        case .logout:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ButtonCell.identifier, for: indexPath) as? ButtonCell
            else { return UITableViewCell() }
            
            cell.configure(with: .logout)
            
            return cell
        }
    }
}

extension ProfileEditViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let row = Row(rawValue: indexPath.row) else { return 0 }
        
        switch row {
        case .profilePicture:
            return 164
            
        case .fullName:
            return 96
        
        case .description:
            return 148
            
        case .logout:
            return 44
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let row = Row(rawValue: indexPath.row) else { return }
        
        switch row {
        case .profilePicture:
            didTapProfilePicture()
            
        case .logout:
            didLogout()
            
        default:
            break
        }
        
    }
    
    private func didTapProfilePicture() {
        print("didTapProfilePicture")
    }
    
    private func didLogout() {
        print("didLogout")
    }
}
