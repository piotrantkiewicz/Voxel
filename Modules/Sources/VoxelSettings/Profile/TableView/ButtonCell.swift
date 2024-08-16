import UIKit
import SnapKit

class ButtonCell: UITableViewCell {

    struct Model {
        let icon: UIImage
        let title: String
    }

    private weak var iconImageView: UIImageView!
    private weak var titleLbl: UILabel!

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    func configure(with model: Model) {
        iconImageView.image = model.icon
        titleLbl.text = model.title
    }

    private func commonInit() {
        setupUI()
    }
}

extension ButtonCell {
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        configureContentView()

        setupIconImageView()
        setupTitle()
    }

    private func configureContentView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
    }

    private func setupIconImageView() {
        let imageView = UIImageView()
        contentView.addSubview(imageView)

        imageView.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }

        iconImageView = imageView
    }

    private func setupTitle() {
        let label = UILabel()
        label.textColor = .text
        label.font = .paragraph

        contentView.addSubview(label)

        label.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.right).offset(16)
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }

        titleLbl = label
    }
}
