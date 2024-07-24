import UIKit
import SnapKit

class ProfileTextFieldCell: UITableViewCell {
    
    struct Model {
        let placeholder: String
        let header: String
        let footer: String?
        let text: String?
        
        init(
            placeholder: String,
            header: String,
            footer: String? = nil,
            text: String? = nil
        ) {
            self.placeholder = placeholder
            self.header = header
            self.footer = footer
            self.text = text
        }
    }
    
    private weak var textField: UITextField!
    private weak var containerView: UIView!
    private weak var headerLbl: UILabel!
    private weak var footerLbl: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    func configure(with model: Model) {
        textField.placeholder = model.placeholder
        textField.text = model.text
        headerLbl.text = model.header
        footerLbl.text = model.footer ?? ""
    }
    
    private func commonInit() {
        setupUI()
    }
}

extension ProfileTextFieldCell {
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        setupContainer()
        setupTextField()
        setupHeader()
        setupFooter()
    }
    
    private func setupContainer() {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        
        contentView.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(44)
            make.top.equalToSuperview().offset(52)
        }
        
        containerView = view
    }
    
    private func setupTextField() {
        let textField = UITextField()
        textField.textColor = .text
        textField.font = .textField
        
        containerView.addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
        
        self.textField = textField
    }
    
    private func setupHeader() {
        let label = UILabel()
        label.textColor = .textGray
        label.font = .title3
        
        contentView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalTo(containerView.snp.top).offset(-8)
        }
        
        self.headerLbl = label
    }
    
    private func setupFooter() {
        let label = UILabel()
        label.textColor = .textGray
        label.font = .footer
        
        contentView.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.top.equalTo(containerView.snp.bottom).offset(8)
        }
        
        self.footerLbl = label
    }
}
