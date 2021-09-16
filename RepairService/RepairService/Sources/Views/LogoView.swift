//
//  LogoView.swift
//  RepairService
//
//  Created by  Buxlan on 9/16/21.
//

import UIKit

class LogoView: UIView {
    
    // MARK: - Properties
    private var backButtonHidden: Bool {
        handleDismissAction == nil
    }
    var handleDismissAction: (() -> Void)? {
        didSet {
            backButton.isHidden = backButtonHidden
        }
    }
    
    private lazy var backButton: UIButton = {
        let image = Asset.back.image.resizeImage(to: 40)
        let view = UIButton()
        view.accessibilityIdentifier = "buttonOurServices"
        view.setImage(image, for: .normal)
//        view.setMargins(margin: 32.0)
        view.backgroundColor = Asset.accent0.color
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return view
    }()
    private var backIconSize: CGSize {
        backButton.image(for: .normal)?.size ?? defaultImageSize
    }
        
    private lazy var logoImageView: UIImageView = {
        let image = Asset.logo.image.resizeImage(to: 60)
        let view = UIImageView()
        view.accessibilityIdentifier = "logoImageView"
        view.image = image
        view.backgroundColor = Asset.accent0.color
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = false
        return view
    }()
    private var imageSize: CGSize {
        logoImageView.image?.size ?? defaultImageSize
    }    
    
    private let defaultImageSize: CGSize = CGSize(width: 400, height: 108)
    private let defaultBackIconSize: CGSize = CGSize(width: 108, height: 108)
    
    // MARK: - Init
    convenience init(handleAction: (() -> Void)? = nil) {
        self.init(frame: .zero)
        self.handleDismissAction = handleAction
        backButton.isHidden = backButtonHidden
    }
    
    private override init(frame: CGRect) {
        self.handleDismissAction = nil
        super.init(frame: frame)
        backgroundColor = Asset.accent0.color
        addSubview(logoImageView)
        addSubview(backButton)
        configureConstraints()
        backButton.isHidden = backButtonHidden
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = Asset.accent0.color
        addSubview(logoImageView)
        addSubview(backButton)
        configureConstraints()
        backButton.isHidden = backButtonHidden
    }
    
    // MARK: - Helper functions
    
    private func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: imageSize.width),
            logoImageView.heightAnchor.constraint(equalToConstant: imageSize.height),
            
            backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            backButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            backButton.widthAnchor.constraint(equalToConstant: backIconSize.width),
            backButton.heightAnchor.constraint(equalToConstant: backIconSize.height),
            backButton.trailingAnchor.constraint(lessThanOrEqualTo: logoImageView.leadingAnchor),
            logoImageView.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc
    private func backButtonTapped() {
       handleDismissAction?()
    }
    
}
