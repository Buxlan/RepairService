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
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        let logoViewHeight: CGFloat = 120
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
            webViewHeightConstraint
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension AboutUsViewController {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.documentElement.scrollHeight", completionHandler: { (height, _) in
            self.webViewHeightConstraint.constant = height as? CGFloat ?? 100
        })
    }
}
