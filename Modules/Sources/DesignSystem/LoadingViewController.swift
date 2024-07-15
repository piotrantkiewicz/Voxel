import UIKit
import Lottie
import SnapKit

enum LottieAnimationFile: String {
    case loading = "lottie-loading"
}

enum LoadingStrings: String {
    case subtitle = "Please wait, content of the page is loading…"
}

public final class LoadingViewController: UIViewController {
    
    private weak var stackView: UIStackView!
    private weak var animationView: LottieAnimationView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupUI()
        animationView.play()
    }
}

extension LoadingViewController {
    
    private func setupUI() {
        view.backgroundColor = UIColor(resource: .background)
        
        setupStackView()
        setupLottie()
        setupSubtitle()
    }
    
    private func setupStackView() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16
        
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
        
        self.stackView = stackView
    }
    
    private func setupLottie() {
        let animationView = LottieAnimationView()
        
        let animation = LottieAnimation.named(
            LottieAnimationFile.loading.rawValue,
            bundle: Bundle.module
        )
        animationView.animation = animation
        animationView.loopMode = .loop
        
        stackView.addArrangedSubview(animationView)
        
        animationView.snp.makeConstraints { make in
            make.size.equalTo(65)
        }
        
        self.animationView = animationView
    }
    
    private func setupSubtitle() {
        let label = UILabel()
        label.text = LoadingStrings.subtitle.rawValue
        label.font = .subtitle
        label.textColor = .textGray
        
        stackView.addArrangedSubview(label)
    }
}
