//
//  AboutUsViewController.swift
//  RepairService
//
//  Created by  Buxlan on 9/16/21.
//

import UIKit
import WebKit

class AboutUsViewController: UIViewController, WKNavigationDelegate {

    // MARK: - Properties
    private var viewModel = AboutUsViewModel()
    
    private lazy var logoView: LogoView = LogoView { [weak self] in
        guard let self = self else {
            return
        }
        self.dismiss(animated: true)
    }
    
    private var mainBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.background.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var button: UIButton = {
        let image = Asset.refill.image.resizeImage(to: 44)
        let view = LeftImageButton()
        view.accessibilityIdentifier = "buttonOurServices"
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
        view.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return view
    }()
    
    private lazy var aboutWebView: WKWebView = {
        let jscript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);"
        let userScript = WKUserScript(source: jscript, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let wkUController = WKUserContentController()
        wkUController.addUserScript(userScript)
        let wkWebConfig = WKWebViewConfiguration()
        wkWebConfig.userContentController = wkUController
        let view = WKWebView(frame: .zero, configuration: wkWebConfig)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Asset.accent0.color
        view.navigationDelegate = self
        if let url = Bundle.main.url(forResource: "about", withExtension: "html") {
            view.loadFileURL(url, allowingReadAccessTo: url)
            let request = URLRequest(url: url)
            view.sizeToFit()
            view.contentMode = .scaleAspectFit
            view.load(request)            
        }
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()
    private lazy var webViewHeightConstraint: NSLayoutConstraint = {
        aboutWebView.heightAnchor.constraint(equalToConstant: 100)
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
        view.addSubview(aboutWebView)
        view.addSubview(button)
        
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
            logoView.bottomAnchor.constraint(equalTo: aboutWebView.topAnchor, constant: -32),
            
            aboutWebView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            aboutWebView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            aboutWebView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor),
            webViewHeightConstraint,
            
            button.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            button.topAnchor.constraint(equalTo: aboutWebView.bottomAnchor, constant: 16),
            button.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            button.heightAnchor.constraint(equalToConstant: buttonsHeight)
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc
    private func buttonTapped() {
        let storyboard = UIStoryboard(name: "PlaceOrderViewController", bundle: nil)
        let vc = storyboard.instantiateInitialViewController()
        guard let unwrappedVC = vc else {
            return
        }
        unwrappedVC.modalPresentationStyle = .pageSheet
        present(unwrappedVC, animated: true)
    }
}

extension AboutUsViewController {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.documentElement.scrollHeight", completionHandler: { (height, _) in
            self.webViewHeightConstraint.constant = height as? CGFloat ?? 100
        })
    }
}
