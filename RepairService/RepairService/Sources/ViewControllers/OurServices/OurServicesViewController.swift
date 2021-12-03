//
//  OurServicesViewController.swift
//  RepairService
//
//  Created by  Buxlan on 9/16/21.
//

import UIKit

class OurServicesViewController: UIViewController {

    // MARK: - Properties
    
    private var viewModel = OurServicesViewModel()
    
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
 
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.isUserInteractionEnabled = true
        view.delegate = self
        view.dataSource = self
        view.allowsSelection = true
        view.allowsMultipleSelection = false
        view.allowsSelectionDuringEditing = false
        view.allowsMultipleSelectionDuringEditing = false
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.rowHeight = UITableView.automaticDimension
//        view.estimatedRowHeight = UITableView.automaticDimension
        view.rowHeight = 60
        view.estimatedRowHeight = 60
        view.register(UITableViewCell.self,
                      forCellReuseIdentifier: "cell")
        
        let frame = CGRect(x: 0, y: 88, width: view.frame.width, height: 100)
        
        let header = UILabel()
        header.text = L10n.ourServices
        header.textAlignment = .center
        header.backgroundColor = Asset.accent1.color
        header.textColor = .yellow
        header.frame.size = CGSize(width: 0, height: 44)
        let attr = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let attrText = NSAttributedString(string: L10n.ourServices, attributes: attr)
        header.attributedText = attrText
        
        view.tableHeaderView = header
        view.tableFooterView = UIView()
        
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
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
        view.addSubview(tableView)
        
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
            logoView.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -32),
            
            tableView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            tableView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension OurServicesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bgColor = (indexPath.row % 2 == 0) ? Asset.accent1.color : Asset.accent0.color
        let textColor = (indexPath.row % 2 == 0) ? UIColor.yellow : UIColor.white
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.backgroundColor = bgColor
        cell.textLabel?.textColor = textColor
        cell.textLabel?.text = viewModel.items[indexPath.row].displayName
        cell.imageView?.image = viewModel.image(at: indexPath.row)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.items.count
    }
    
}
