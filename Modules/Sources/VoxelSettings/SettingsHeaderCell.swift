import UIKit
import DesignSystem
import SnapKit

class SettingsHeaderCell: UITableViewCell {
    
    private var containerView: UIView!
    private var stackView: UIStackView!
    private var profileImageView: UIImageView!
    private var nameLbl: UILabel!
    private var descriptionLbl: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    func configure(with viewModel: SettingsViewModel.Header) {
        profileImageView.image = viewModel.image
        nameLbl.text = viewModel.name
        descriptionLbl.text = viewModel.description
    }
    
    private func commonInit() {
        setupUI()
    }
}

extension SettingsHeaderCell {
    
    private func setupUI() {
        backgroundColor = .clear
        
        setupContainer()
        setupStackView()
        setupImageView()
        setupLabels()
        setupIndicator()
    }
    
    private func setupContainer() {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        
        contentView.addSubview(view)
        
        self.containerView = view
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    private func setupStackView() {
        stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .center
        
        containerView.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-8)
            make.top.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-12)
        }
    }
    
    private func setupImageView() {
        profileImageView = UIImageView()
        stackView.addArrangedSubview(profileImageView)
        
        profileImageView.snp.makeConstraints { make in
            make.size.equalTo(56)
        }
    }
    
    private func setupLabels() {
        let labelsStackView = UIStackView()
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 2
        
        let nameLbl = setupNameLbl()
        labelsStackView.addArrangedSubview(nameLbl)
        self.nameLbl = nameLbl
        
        let descriptionLbl = setupDescriptionLbl()
        labelsStackView.addArrangedSubview(descriptionLbl)
        self.descriptionLbl = descriptionLbl
        
        stackView.addArrangedSubview(labelsStackView)
    }
    
    private func setupNameLbl() -> UILabel {
        let nameLbl = UILabel()
        nameLbl.font = .title2
        nameLbl.textColor = .black
        return nameLbl
    }
    
    private func setupDescriptionLbl() -> UILabel {
        let descriptionLbl = UILabel()
        descriptionLbl.font = .subtitle2
        descriptionLbl.textColor = .textGray
        return descriptionLbl
    }
    
    private func setupIndicator() {
        let indicatorImageView = UIImageView()
        indicatorImageView.contentMode = .scaleAspectFit
        indicatorImageView.image = .indicator
        stackView.addArrangedSubview(indicatorImageView)
        
        indicatorImageView.snp.makeConstraints { make in
            make.size.equalTo(24)
        }
    }
}
