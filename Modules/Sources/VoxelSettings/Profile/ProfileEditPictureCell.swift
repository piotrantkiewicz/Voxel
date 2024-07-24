import UIKit
import SnapKit

class ProfileEditPictureCell: UITableViewCell {
    
    private weak var profileImageView: UIImageView!
    private weak var setNewAvatarBtn: UIButton!
    
    var didTap: (()->())?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    func configure(with image: UIImage?) {
        if let image {
            profileImageView.image = image
        }
    }
    
    private func commonInit() {
        setupUI()
    }
}

extension ProfileEditPictureCell {
    
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        setupProfileImageView()
        setupSetNewAvatarBtn()
    }
    
    private func setupProfileImageView() {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 48
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(resource: .avatar)
        
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(16)
            make.size.equalTo(96)
        }
        
        self.profileImageView = imageView
    }
    
    private func setupSetNewAvatarBtn() {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .button
        button.setTitleColor(.accent, for: .normal)
        button.setTitleColor(.accent, for: .highlighted)
        button.setTitleColor(.accent, for: .selected)
        button.setTitle(ProfileEditStrings.setNewAvatar.rawValue, for: .normal)
        button.addTarget(self, action: #selector(didTapBtn), for: .touchUpInside)
        
        contentView.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(8)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        self.setNewAvatarBtn = button
    }
    
    @objc
    private func didTapBtn() {
        didTap?()
    }
}
