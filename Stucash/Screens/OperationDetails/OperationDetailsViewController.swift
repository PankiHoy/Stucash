//
//  OperationDetailsViewController.swift
//  Stucash
//
//  Created by Maksim Karaseu on 19.04.23.
//

import Foundation
import UIKit

final class OperationDetailsViewController: UIViewController,
                                            OperationDetailsDisplayLogic {
    typealias Models = OperationDetailsModels
    
    private let interactor: OperationDetailsBusinessLogic
    private let router: OperationDetailsRoutingLogic
    
    // FIXME: убрать нахуй этот позор и переделать с перерисовкой вьюх
    private var operationTitle: String?
    private var operationDescription: String?
    private var price: String?
    private var pricePositive: Bool = false
    private var date: String?
    private var type: OperationType = .buy
    
    private let modalHeaderView: UIView = UIView()
    private let iconView: UIImageView = UIImageView()
    private let titleView: UILabel = UILabel()
    private let descriptionView: UILabel = UILabel()
    private let priceView: UILabel = UILabel()
    private let dateView: UILabel = UILabel()
    private let qrView: UIImageView = UIImageView()
    
    init(interactor: OperationDetailsBusinessLogic, router: OperationDetailsRoutingLogic) {
        self.interactor = interactor
        self.router = router
        
        super.init(nibName: nil, bundle: nil)
        
        configureUI()
        
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = UIColor.stucashBlack
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        interactor.requestInitForm(Models.InitialData.Request())
    }
    
    // MARK: OperationDetailsDisplayLogic
    func displayInitForm(_ viewModel: OperationDetailsModels.InitialData.ViewModel) {
        self.operationTitle = viewModel.title
        self.operationDescription = viewModel.subtitle
        self.price = viewModel.price
        self.pricePositive = viewModel.pricePostitive
        self.date = viewModel.date
        self.type = viewModel.type
        self.view.setNeedsLayout()
    }
    
    func displayRedeemStatus(_ viewModel: OperationDetailsModels.Redeem.ViewModel) { }
    
    func displayStatusError() { }
    
    // MARK: Private
    private func configureUI() {
        configureFields()
    }
    
    override func viewWillLayoutSubviews() {
        modalHeaderView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(modalHeaderView)
        
        modalHeaderView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 8.0).isActive = true
        modalHeaderView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        modalHeaderView.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        modalHeaderView.heightAnchor.constraint(equalToConstant: 5.0).isActive = true
        
        iconView.image = self.type.image
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(iconView)
        
        iconView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 30.0).isActive = true
        iconView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        
        titleView.text = self.operationTitle ?? ""
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(titleView)
        
        titleView.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 20.0).isActive = true
        titleView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true

        descriptionView.text = self.operationDescription ?? ""
        
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(descriptionView)
        
        descriptionView.topAnchor.constraint(equalTo: titleView.bottomAnchor).isActive = true
        descriptionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true

        priceView.text = self.price ?? ""
        priceView.textColor = self.pricePositive ? .green : .red
        
        priceView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(priceView)
        
        priceView.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: 20.0).isActive = true
        priceView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true

        dateView.text = self.date ?? ""
        
        dateView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(dateView)
        
        dateView.topAnchor.constraint(equalTo: priceView.bottomAnchor).isActive = true
        dateView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true

        qrView.image = UIImage(named: "qrOperation")
        
        qrView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(qrView)
        
        qrView.topAnchor.constraint(equalTo: dateView.bottomAnchor, constant: 20.0).isActive = true
        qrView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        qrView.heightAnchor.constraint(equalToConstant: 115.0).isActive = true
        qrView.widthAnchor.constraint(equalToConstant: 115.0).isActive = true
    }
    
    private func configureFields() {
        self.modalHeaderView.isUserInteractionEnabled = false
        self.modalHeaderView.backgroundColor = UIColor.stucashGrey
        self.modalHeaderView.layer.cornerRadius = 2.5
        
        self.iconView.tintColor = UIColor.stucashGold
        self.iconView.isUserInteractionEnabled = false
        
        self.titleView.isUserInteractionEnabled = false
        self.titleView.textColor = UIColor.stucashWhite
        self.titleView.font = UIFont.stucashRegular(ofSize: 20.0)
        
        self.descriptionView.isUserInteractionEnabled = false
        self.descriptionView.textColor = UIColor.stucashGrey
        self.descriptionView.font = UIFont.systemFont(ofSize: 15.0)
        
        self.priceView.isUserInteractionEnabled = false
        self.priceView.textColor = UIColor.stucashGold
        self.priceView.font = UIFont.stucashRegular(ofSize: 20.0)
        
        self.dateView.isUserInteractionEnabled = false
        self.dateView.textColor = UIColor.stucashGrey
        self.dateView.font = UIFont.systemFont(ofSize: 15.0)
        
        self.qrView.isUserInteractionEnabled = false
    }
}
