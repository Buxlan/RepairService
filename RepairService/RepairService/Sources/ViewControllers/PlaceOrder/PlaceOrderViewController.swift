//
//  PlaceOrderViewController.swift
//  RepairService
//
//  Created by  Buxlan on 9/16/21.
//

import UIKit
import MessageUI

class PlaceOrderViewController: UIViewController {
        
    // MARK: Properties
    @IBOutlet var logoView: LogoView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var contentView: UIView!
    @IBOutlet var placeOrderButton: UIButton!
    @IBOutlet var labelOrder: UILabel!
    @IBOutlet var labelDevice: UILabel!
    @IBOutlet var contactsLabel: UILabel!
    @IBOutlet var deviceNameTextField: UITextField!
    @IBOutlet var brokeDescriptionTextField: UITextField!
    @IBOutlet var phoneNumberTextField: UITextField!
    @IBOutlet var companyTextField: UITextField!
    @IBOutlet var addressTextField: UITextField!    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var isCompanySwitch: UISwitch!
    @IBOutlet var isCompanyLabel: UILabel!
    @IBOutlet var horizontalStackView: UIStackView!
    @IBOutlet var stackView0: UIStackView!
    @IBOutlet var stackView1: UIStackView!
    
    private var viewModel = PlaceOrderViewModel()
    private lazy var textFields: [UITextField] = {
        let items: [UITextField] = [
            phoneNumberTextField,
            companyTextField,
            addressTextField,
            emailTextField,
            deviceNameTextField,
            brokeDescriptionTextField
        ]
        return items
    }()
    
    enum KeyboardState {
        case unknown
        case entering
        case exiting
    }
    private lazy var oldContentInset: UIEdgeInsets = {
        self.scrollView.contentInset
    }()
    private lazy var oldOffset: CGPoint = {
        self.scrollView.contentOffset
    }()
    
    private var mainBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Asset.background.color
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var stack0BackgroundView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = Asset.accent1.color.cgColor
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var stack1BackgroundView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = Asset.accent1.color.cgColor
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.restore()
        configureUI()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: Helper functions
    func configureUI() {
        view.insertSubview(mainBackgroundView, at: 0)
        contentView.insertSubview(stack0BackgroundView, at: 0)
        contentView.insertSubview(stack1BackgroundView, at: 0)
        scrollView.showsVerticalScrollIndicator = false
        
        stackView0.translatesAutoresizingMaskIntoConstraints = false
        stackView1.translatesAutoresizingMaskIntoConstraints = false
        placeOrderButton.translatesAutoresizingMaskIntoConstraints = false
        labelOrder.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        logoView.translatesAutoresizingMaskIntoConstraints = false
        
        deviceNameTextField.delegate = self
        brokeDescriptionTextField.delegate = self
        phoneNumberTextField.delegate = self
        companyTextField.delegate = self
        addressTextField.delegate = self
        emailTextField.delegate = self
        
        isCompanySwitch.setOn(viewModel.isCompany, animated: false)
        
        logoView.handleDismissAction = { [weak self] in
            guard let self = self else {
                return
            }
            self.dismiss(animated: true)
        }
        
        view.backgroundColor = Asset.accent1.color
        
        stackView0.distribution = .fillEqually
        stackView0.spacing = 8        
        
        stackView1.distribution = .fillEqually
        stackView1.spacing = 8
                
        placeOrderButton.layer.cornerRadius = 16
        placeOrderButton.clipsToBounds = true
        
        horizontalStackView.alignment = .center
        
        configureTextFields()
        configureConstraints()
    }
    
    private func configureConstraints() {
        let logoViewHeight: CGFloat = 120
        let constraints: [NSLayoutConstraint] = [
            mainBackgroundView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            mainBackgroundView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            mainBackgroundView.widthAnchor.constraint(equalTo: view.widthAnchor),
            mainBackgroundView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),

            logoView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            logoView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            logoView.widthAnchor.constraint(equalTo: view.widthAnchor),
            logoView.heightAnchor.constraint(equalToConstant: logoViewHeight),

            scrollView.topAnchor.constraint(equalTo: logoView.bottomAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            labelOrder.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            labelOrder.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -64),
            labelOrder.topAnchor.constraint(equalTo: contentView.topAnchor),
            labelOrder.heightAnchor.constraint(equalToConstant: 40),
            
            stackView0.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView0.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -64),
            stackView0.topAnchor.constraint(equalTo: labelOrder.bottomAnchor, constant: 0),
            stackView0.heightAnchor.constraint(equalToConstant: 304),
            
            stackView1.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView1.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -64),
            stackView1.topAnchor.constraint(equalTo: stackView0.bottomAnchor, constant: 16),
            stackView1.heightAnchor.constraint(equalToConstant: 148),
            
            stack0BackgroundView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stack0BackgroundView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -48),
            stack0BackgroundView.centerYAnchor.constraint(equalTo: stackView0.centerYAnchor, constant: 0),
            stack0BackgroundView.heightAnchor.constraint(equalToConstant: 312),
            
            stack1BackgroundView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stack1BackgroundView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -48),
            stack1BackgroundView.centerYAnchor.constraint(equalTo: stackView1.centerYAnchor, constant: 8),
            stack1BackgroundView.heightAnchor.constraint(equalToConstant: 152),
            
            placeOrderButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            placeOrderButton.widthAnchor.constraint(equalToConstant: 100),
            placeOrderButton.topAnchor.constraint(equalTo: stackView1.bottomAnchor, constant: 16),
            placeOrderButton.heightAnchor.constraint(equalToConstant: 60),
            placeOrderButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    private func configureTextFields() {
        phoneNumberTextField.text = viewModel.phoneNumber
        companyTextField.text = viewModel.companyName
        addressTextField.text = viewModel.address
        emailTextField.text = viewModel.email
        deviceNameTextField.text = viewModel.device
        brokeDescriptionTextField.text = viewModel.brokeDescription
    }
    
    @objc
    private func buttonPlaceOrderTapped() {
        let vc = PlaceOrderViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @IBAction func valueChanged(_ sender: UISwitch) {
        viewModel.isCompany = sender.isOn
    }
    
    func keyboardState(for dictionary: [AnyHashable: Any], in view: UIView?) -> (KeyboardState, CGRect?) {
        
        guard var rectOld = dictionary[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect,
              var rectNew = dictionary[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let view = view else {
            print("Something goes wrong")
            return (KeyboardState.unknown, CGRect.zero)
        }
        var keyboardState: KeyboardState = .unknown
        var newRect: CGRect?
        let co = UIScreen.main.coordinateSpace
        rectOld = co.convert(rectOld, to: view)
        rectNew = co.convert(rectNew, to: view)
        newRect = rectNew
        if !rectOld.intersects(view.bounds) && rectNew.intersects(view.bounds) {
            keyboardState = .entering
        }
        if rectOld.intersects(view.bounds) && !rectNew.intersects(view.bounds) {
            keyboardState = .exiting
        }
        return (keyboardState, newRect)
    }
    
    @objc func keyboardShow(_ notification: Notification) {
        let dict = notification.userInfo!
        let (state, rnew) = keyboardState(for: dict, in: self.scrollView)
        if state == .unknown {
            return
        } else if state == .entering {
            self.oldContentInset = self.scrollView.contentInset
            self.oldOffset = self.scrollView.contentOffset
        }
        if let rnew = rnew {
            let height = rnew.intersection(self.scrollView.bounds).height
            self.scrollView.contentInset.bottom = height
        }
    }
    
    @objc func keyboardHide(_ notification: Notification) {
        let dict = notification.userInfo!
        let (state, _) = keyboardState(for: dict, in: self.scrollView)
        if state == .exiting {
            self.scrollView.contentOffset = self.oldOffset
            self.scrollView.contentInset = self.oldContentInset
        }
    }
    
    @IBAction func placeOrderTapped(_ sender: UIButton) {
        sendEmail()
    }
    
    private func sendEmail() {
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            return
        }
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
         
        // Configure the fields of the interface.
        composeVC.setToRecipients(["buxlan51@gmail.com"])
        
        composeVC.setSubject("New order!")
        composeVC.setMessageBody(viewModel.getMailBody(), isHTML: false)
         
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
    }
    
}

extension PlaceOrderViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if reason != .committed {
            return
        }
        
        switch textField {
        case phoneNumberTextField:
            viewModel.phoneNumber = textField.text
        case companyTextField:
            viewModel.companyName  = textField.text
        case addressTextField:
            viewModel.address = textField.text
        case emailTextField:
            viewModel.email  = textField.text
        case deviceNameTextField:
            viewModel.device = textField.text
        case brokeDescriptionTextField:
            viewModel.brokeDescription  = textField.text
        default:
            print("Unknown text field \(textField)")
            return
        }
        viewModel.save()
        
        guard let index = textFields.firstIndex(of: textField) else {
            print("Text field \(textField) not found")
            return
        }
        if index == textFields.count - 1 {
            textField.resignFirstResponder()
            sendEmail()
        } else {
            textFields[index+1].becomeFirstResponder()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldDidEndEditing(textField, reason: .committed)
        return true
    }
}

extension PlaceOrderViewController {
    
    override func encodeRestorableState(with coder: NSCoder) {
        coder.encode(viewModel.phoneNumber, forKey: "phoneNumber")
        coder.encode(viewModel.companyName, forKey: "companyName")
        coder.encode(viewModel.address, forKey: "address")
        coder.encode(viewModel.email, forKey: "email")
        coder.encode(viewModel.device, forKey: "device")
        coder.encode(viewModel.brokeDescription, forKey: "brokeDescription")
        super.encodeRestorableState(with: coder)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        if let phoneNumber = coder.decodeObject(forKey: "phoneNumber") as? String {
            viewModel.phoneNumber = phoneNumber
        }
        if let companyName = coder.decodeObject(forKey: "companyName") as? String {
            viewModel.companyName = companyName
        }
        if let address = coder.decodeObject(forKey: "address") as? String {
            viewModel.address = address
        }
        if let email = coder.decodeObject(forKey: "email") as? String {
            viewModel.email = email
        }
        if let device = coder.decodeObject(forKey: "device") as? String {
            viewModel.device = device
        }
        if let brokeDescription = coder.decodeObject(forKey: "brokeDescription") as? String {
            viewModel.brokeDescription = brokeDescription
        }
        configureTextFields()
        super.decodeRestorableState(with: coder)
    }
}

extension PlaceOrderViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
