import UIKit
import SnapKit
import DesignSystem
import VoxelCore
import SDWebImage

class ContactCell: UITableViewCell {

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .title2
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(profileImageView)
        containerView.addSubview(nameLabel)

        backgroundColor = .clear
        contentView.backgroundColor = .clear
        selectionStyle = .none

        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        }

        profileImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(profileImageView.snp.height)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }

        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
        }
    }

    func configure(with contact: Contact) {
        nameLabel.text = contact.name
        
        profileImageView.image = .avatar
        
        if let url = contact.profilePictureUrl {
            profileImageView.sd_setImage(with: url)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        profileImageView.sd_cancelCurrentImageLoad()
    }
    
    func configureCellCorners(corners: UIRectCorner) {
        containerView.layer.cornerRadius = 10
        containerView.setMaskedCorners(corners)
    }
}
