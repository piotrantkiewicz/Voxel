import UIKit
import SnapKit
import DesignSystem
import VoxelAuthentication

enum OTPStrings: String {
    case title = "Enter the code"
    case subtitle = "Enter the code we sent to"
    case continueButton = "Continue"
}

enum OTPViewModelError: Error {
    case otpNotValid
}

public final class OTPViewModel {
    
    private var authService: AuthService
    
    init(authService: AuthService) {
        self.authService = authService
    }
    
    func verifyOTP(with digits: [String]) async throws {
        
        guard validate(digits: digits) else {
            throw OTPViewModelError.otpNotValid
        }
        let otp = combineToOTP(digits: digits)
        
        let user = try await authService.authenticate(with: otp)
        print(user.uid)
    }
    
    private func validate(digits: [String]) -> Bool {
        for digit in digits {
            guard digit.isValidDigit else { return false }
        }
        
        return true
    }
    
    private func combineToOTP(digits: [String]) -> String {
        digits.joined()
    }
}

fileprivate extension String {
    var isValidDigit: Bool {
        guard count == 1 else { return false }
        guard isNumber else { return false }
        return true
    }
}

extension String {
    var isNumber: Bool {
        let digitsCharacters = CharacterSet(charactersIn: "0123456789")
        return CharacterSet(charactersIn: self).isSubset(of: digitsCharacters)
    }
}

public final class OTPViewController: UIViewController {
    
    private weak var stackView: UIStackView!
    private weak var continueBtn: UIButton!
    private var textFields: [UITextField] = []
    
    var phoneNumber: String = ""
    
    public var viewModel: OTPViewModel!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        continueBtn.alpha = 0.5
        textFields.first?.becomeFirstResponder()
    }
}

extension OTPViewController {
    
    private func setupUI() {
        
        view.backgroundColor = .background
        
        setupStackView()
        setupIcon()
        setupTitle()
        setupSubtitle()
        setupOTPTextFields()
        setupContinueButton()
    }
    
    private func setupStackView() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 24
        
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        self.stackView = stackView
    }
    
    private func setupIcon() {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        icon.image = UIImage(resource: .mobileOtp)
        
        stackView.addArrangedSubview(icon)
        
        icon.snp.makeConstraints { make in
            make.size.equalTo(80)
        }
    }
    
    private func setupTitle() {
        let title = UILabel()
        
        let attributedString = NSAttributedString(
            string: OTPStrings.title.rawValue,
            attributes: [
                .kern: Kern.fromFigmaToiOS(figmaLetterSpacing: 0.37),
                .paragraphStyle: UIFont.title
                    .paragraphStyle(forLineHight: 41)
                
            ]
        )
        title.attributedText = attributedString
        title.font = .title
        title.numberOfLines = 0
        title.textAlignment = .center
        title.textColor = .text

        stackView.addArrangedSubview(title)
    }
    
    private func setupSubtitle() {
        let subtitle = UILabel()
        let attributedString = NSAttributedString(
            string: OTPStrings.subtitle.rawValue + "\n" + phoneNumber,
            attributes: [
                .kern: Kern.fromFigmaToiOS(figmaLetterSpacing: -0.41)
            ]
        )
        subtitle.attributedText = attributedString
        subtitle.font = .subtitle
        subtitle.numberOfLines = 0
        subtitle.textAlignment = .center
        subtitle.textColor = .text

        stackView.addArrangedSubview(subtitle)
    }
    
    private func setupOTPTextFields() {
        
        var fields = [UITextField]()
        
        let fieldsStackView = UIStackView()
        fieldsStackView.axis = .horizontal
        fieldsStackView.spacing = 16
        fieldsStackView.alignment = .center
        
        for index in 0...5 {
            let background = UIView()
            background.backgroundColor = .white
            background.layer.cornerRadius = 8
            background.layer.masksToBounds = true
            
            let textField = UITextField()
            textField.textAlignment = .center
            textField.textColor = .textGray
            textField.font = .otp
            textField.keyboardType = .numberPad
            textField.addTarget(self, action: #selector(didChangeText), for: .editingChanged)
            textField.tag = 100 + index
            
            background.addSubview(textField)
            
            background.snp.makeConstraints { make in
                make.height.equalTo(44)
                make.width.equalTo(44)
            }
            
            textField.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            fieldsStackView.addArrangedSubview(background)
            fields.append(textField)
        }
        
        stackView.addArrangedSubview(fieldsStackView)
        
        textFields = fields
    }
    
    private func setupContinueButton() {
        let button = UIButton()
        button.backgroundColor = .accent
        button.titleLabel?.font = .button
        button.setTitle(OTPStrings.continueButton.rawValue, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(didTapContinue), for: .touchUpInside)
        
        stackView.addArrangedSubview(button)
        
        button.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalToSuperview()
        }
        
        self.continueBtn = button
    }
}

extension OTPViewController {
    
    @objc func didChangeText(textField: UITextField) {
        let index = textField.tag - 100
        
        let nextIndex = index + 1
        
        guard nextIndex < textFields.count else {
            didTapContinue()
            continueBtn.alpha = 1.0
            return
        }
        
        textFields[nextIndex].becomeFirstResponder()
        
    }
}

extension OTPViewController {
    
    private func setContinueBtnDisabled() {
        continueBtn.alpha = 0.5
        continueBtn.isEnabled = false
    }
    
    private func setContinueBtnEnabled() {
        continueBtn.alpha = 1.0
        continueBtn.isEnabled = true
    }
    
    @objc func didTapContinue() {
        view.endEditing(true)
        self.setContinueBtnDisabled()
        
        let digits = textFields.map { $0.text ?? "" }
        
        let loadingVC = LoadingViewController()
        loadingVC.modalPresentationStyle = .overCurrentContext
        self.present(loadingVC, animated: true)
        
        Task { [weak self] in
            do {
                try await self?.viewModel.verifyOTP(with: digits)
                
                loadingVC.dismiss(animated: true) { [weak self] in
                    let vc = UIViewController()
                    vc.modalPresentationStyle = .fullScreen
                    self?.present(vc, animated: true)
                }
            } catch {
                loadingVC.dismiss(animated: true) { [weak self] in   
                    self?.showError(error.localizedDescription)
                    self?.setContinueBtnEnabled()
                }
            }
        }
    }
}


