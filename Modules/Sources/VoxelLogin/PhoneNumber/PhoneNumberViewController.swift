import UIKit
import DesignSystem
import VoxelAuthentication
import VoxelCore
import PhoneNumberKit
import SnapKit

enum PhoneNumberStrings: String {
    case title = "Enter your phone number"
    case subtitle = "What a phone number can people use to reach you?"
    case continueButton = "Continue"
}

public class PhoneNumberViewController: UIViewController {
    
    private weak var stackView: UIStackView!
    private weak var textField: PhoneNumberTextField!
    private weak var continueBtn: UIButton!
    
    public var viewModel: PhoneNumberViewModel!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        subscribeToTextChange()
        textFieldDidChange()
        
        textField.becomeFirstResponder()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func subscribeToTextChange() {
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidChange), name: UITextField.textDidChangeNotification, object: self)
    }
}

extension PhoneNumberViewController {
    
    private func setupUI() {
        
        view.backgroundColor = .background
        
        setupStackView()
        setupIcon()
        setupTitle()
        setupSubtitle()
        setupTextField()
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
        icon.image = UIImage(resource: .mobileEditPen)
        
        stackView.addArrangedSubview(icon)
        
        icon.snp.makeConstraints { make in
            make.size.equalTo(80)
        }
    }
    
    private func setupTitle() {
        let title = UILabel()
        
        let attributedString = NSAttributedString(
            string: PhoneNumberStrings.title.rawValue,
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
            string: PhoneNumberStrings.subtitle.rawValue,
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
    
    private func setupTextField() {
        let textFieldBackground = UIView()
        textFieldBackground.backgroundColor = .white
        textFieldBackground.layer.cornerRadius = 8
        textFieldBackground.layer.masksToBounds = true
        stackView.addArrangedSubview(textFieldBackground)
        textFieldBackground.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(44)
        }
        
        let textField = PhoneNumberTextField(
            insets: UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8),
            clearButtonPadding: 0
        )
  
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textField.font = .textField
        textField.textColor = .text
        textField.withExamplePlaceholder = true
        textField.withFlag = true
        
        textFieldBackground.addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.centerY.equalToSuperview()
        }
        
        self.textField = textField
    }
    
    private func setupContinueButton() {
        let button = UIButton()
        button.backgroundColor = .accent
        button.titleLabel?.font = .button
        button.setTitle(PhoneNumberStrings.continueButton.rawValue, for: .normal)
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

extension PhoneNumberViewController {
    @objc func textFieldDidChange() {
        continueBtn.isEnabled = textField.isValidNumber
        continueBtn.alpha = textField.isValidNumber ? 1.0 : 0.25
    }
}

extension PhoneNumberViewController {
    
    @objc func didTapContinue() {
        
        guard
            textField.isValidNumber, 
            let phoneNumber = textField.text else { return }
        
        Task { [weak self] in
            do {
                try await self?.viewModel.requestOTP(with: phoneNumber)
            } catch {
                self?.showError(error.localizedDescription)
            }
        }
    }
}
