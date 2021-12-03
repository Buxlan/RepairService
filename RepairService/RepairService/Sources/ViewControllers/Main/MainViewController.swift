//
//  ViewController.swift
//  RepairService
//
//  Created by  Buxlan on 9/15/21.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: Properties
    private var viewModel = MainViewModel()
    private lazy var logoView: LogoView = LogoView()
    
    private lazy var placeOrderButton: LeftImageButton = {
        let image = Asset.refill.image.resizeImage(to: 44)
        let view = LeftImageButton()
        view.accessibilityIdentifier = "buttonPlaceOrder"
        view.setTitle(L10n.placeOrder, for: .normal)
        view.setImage(image, for: .normal)
//        view.setMargins(margin: 32.0)
        view.backgroundColor = Asset.background.color
        view.setTitleColor(.black, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.layer.borderColor = UIColor.black.withAlphaComponent(0.8).cgColor
        view.layer.borderWidth = 0.5
        view.clipsToBounds = true
        view.contentEdgeInsets = .init(top: 0, left: 12, bottom: 0, right: 12)
        view.addTarget(self, action: #selector(buttonPlaceOrderTapped), for: .touchUpInside)
        return view
    }()
    
    private lazy var ourServicesButton: LeftImageButton = {
        let image = Asset.repair.image.resizeImage(to: 44)
        let view = LeftImageButton()
        view.accessibilityIdentifier = "buttonOurServices"
        view.setTitle(L10n.ourServices, for: .normal)
        view.setImage(image, for: .normal)
//        view.setMargins(margin: 32.0)
        
        view.backgroundColor = Asset.background.color
        view.setTitleColor(.black, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.layer.borderColor = UIColor.black.withAlphaComponent(0.8).cgColor
        view.layer.borderWidth = 0.5
        view.clipsToBounds = true
        view.contentEdgeInsets = .init(top: 0, left: 12, bottom: 0, right: 12)
        view.addTarget(self, action: #selector(ourServicesButtonTapped), for: .touchUpInside)
        return view
    }()
    
    private lazy var aboutUsButton: LeftImageButton = {
        let image = Asset.info.image.resizeImage(to: 44)
        let view = LeftImageButton()
        view.accessibilityIdentifier = "buttonAboutUs"
        view.setTitle(L10n.aboutUs, for: .normal)
        view.setImage(image, for: .normal)
//        view.setMargins(margin: 32.0)
        view.backgroundColor = Asset.background.color
        view.setTitleColor(.black, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.layer.borderColor = UIColor.black.withAlphaComponent(0.8).cgColor
        view.layer.borderWidth = 0.5
        view.clipsToBounds = true
        view.contentEdgeInsets = .init(top: 0, left: 12, bottom: 0, right: 12)
        view.addTarget(self, action: #selector(aboutUsButtonTapped), for: .touchUpInside)
        return view
    }()
    
    private lazy var callUsButton: UIButton = {
        let image = Asset.call.image.resizeImage(to: 60)
        let view = UIButton()
        view.accessibilityIdentifier = "buttonCallUs"
        view.setImage(image, for: .normal)
        view.backgroundColor = Asset.background.color
        view.setTitleColor(.black, for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(callUsButtonTapped), for: .touchUpInside)
        return view
    }()
    
    private var mainBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.background.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: Helper functions
    func configureUI() {
        view.backgroundColor = Asset.accent1.color
        logoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainBackgroundView)
        view.addSubview(logoView)
        view.addSubview(placeOrderButton)
        view.addSubview(ourServicesButton)
        view.addSubview(aboutUsButton)
        view.addSubview(callUsButton)
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        let logoViewHeight: CGFloat = 120
        let buttonsHeight: CGFloat = 60
        let constraints: [NSLayoutConstraint] = [
            mainBackgroundView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            mainBackgroundView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            mainBackgroundView.widthAnchor.constraint(equalTo: view.widthAnchor),
            mainBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            logoView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            logoView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            logoView.widthAnchor.constraint(equalTo: view.widthAnchor),
            logoView.heightAnchor.constraint(equalToConstant: logoViewHeight),
            logoView.bottomAnchor.constraint(lessThanOrEqualTo: ourServicesButton.topAnchor),

            ourServicesButton.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            ourServicesButton.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor),
            ourServicesButton.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            ourServicesButton.heightAnchor.constraint(equalToConstant: buttonsHeight),

            placeOrderButton.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            placeOrderButton.bottomAnchor.constraint(equalTo: ourServicesButton.topAnchor, constant: -16),
            placeOrderButton.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            placeOrderButton.heightAnchor.constraint(equalToConstant: buttonsHeight),

            aboutUsButton.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            aboutUsButton.topAnchor.constraint(equalTo: ourServicesButton.bottomAnchor, constant: 16),
            aboutUsButton.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            aboutUsButton.heightAnchor.constraint(equalToConstant: buttonsHeight),
            aboutUsButton.bottomAnchor.constraint(lessThanOrEqualTo: callUsButton.topAnchor),

            callUsButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -16),
            callUsButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -32),
            callUsButton.widthAnchor.constraint(equalToConstant: buttonsHeight),
            callUsButton.heightAnchor.constraint(equalToConstant: buttonsHeight)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc
    private func buttonPlaceOrderTapped() {
        let storyboard = UIStoryboard(name: "PlaceOrderViewController", bundle: nil)
        let vc = storyboard.instantiateInitialViewController()
        guard let unwrappedVC = vc else {
            return
        }
        unwrappedVC.modalTransitionStyle = .crossDissolve
        unwrappedVC.modalPresentationStyle = .fullScreen
        present(unwrappedVC, animated: true)
    }
    
    @objc
    private func ourServicesButtonTapped() {
        let vc = OurServicesViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc
    private func aboutUsButtonTapped() {
        let vc = AboutUsViewController()
//        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc
    private func callUsButtonTapped() {
        let phoneNumber = viewModel.company.phoneNumber ?? ""
        guard let url = URL(string: "telprompt://\(phoneNumber)"),
              UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}

extension MainViewController {
    override func encodeRestorableState(with coder: NSCoder) {
        super.encodeRestorableState(with: coder)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {        
        super.decodeRestorableState(with: coder)
    }
}
