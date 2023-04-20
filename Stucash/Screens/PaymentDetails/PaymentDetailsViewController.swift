//
//  PaymentDetailsViewController.swift
//  Stucash
//
//  Created by Maksim Karaseu on 20.04.23.
//

import Foundation
import UIKit

final class PaymentDetailsViewController: UIViewController,
                                          PaymentDetailsDisplayLogic {
    typealias Models = PaymentDetailsModels
    
    private let interactor: PaymentDetailsInteractor
    private let router: PaymentDetailsRoutingLogic
    
    // FIXME: тоже самое, убрать позорище и переделать с обновлением даты на следующей итерации лупа
    var paymentTitle: String = ""
    var paymentDescription: String = ""
    var price: String = ""
    
    let modalHeaderView: UIView
    let cardImage: SmallCardView
    let balanceView: UILabel
    let separatorView: UIView
    let titleView: UILabel
    let subtitleView: UILabel
    let priceView: UILabel
    let infoView: UILabel
    
    private let proceedButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6.0
        button.backgroundColor = UIColor.stucashGold
        button.setAttributedTitle(
            NSAttributedString(
                string: "PROCEED",
                attributes: [
                    NSAttributedString.Key.foregroundColor : UIColor.stucashBlack ?? .black,
                    NSAttributedString.Key.font : UIFont.stucashRegular(ofSize: 20.0),
                    NSAttributedString.Key.kern : 2.0
                ]
            ),
            for: .normal
        )
        
        return button
    }()
    
    init(interactor: PaymentDetailsInteractor, router: PaymentDetailsRoutingLogic) {
        self.interactor = interactor
        self.router = router
        
        self.modalHeaderView = UIView()
        self.modalHeaderView.isUserInteractionEnabled = false
        self.modalHeaderView.backgroundColor = UIColor.stucashGrey
        self.modalHeaderView.layer.cornerRadius = 2.5
        
        self.cardImage = SmallCardView()
        self.cardImage.isUserInteractionEnabled = false
        self.cardImage.backgroundColor = UIColor.stucashGold
        self.cardImage.layer.cornerRadius = 12.0
        
        self.balanceView = UILabel()
        self.balanceView.isUserInteractionEnabled = false
        self.balanceView.textColor = UIColor.stucashWhite
        self.balanceView.font = UIFont.stucashRegular(ofSize: 55.0)
        
        self.separatorView = UIView()
        self.separatorView.backgroundColor = UIColor.stucashGrey
        
        self.titleView = UILabel()
        self.titleView.isUserInteractionEnabled = false
        self.titleView.textColor = UIColor.stucashWhite
        self.titleView.font = UIFont.stucashRegular(ofSize: 30.0)
        
        self.subtitleView = UILabel()
        self.subtitleView.isUserInteractionEnabled = false
        self.subtitleView.textColor = UIColor.stucashGrey
        self.subtitleView.font = UIFont.systemFont(ofSize: 25.0)
        
        self.priceView = UILabel()
        self.priceView.isUserInteractionEnabled = false
        self.priceView.textColor = UIColor.stucashGold
        self.priceView.font = UIFont.stucashRegular(ofSize: 30.0)
        
        self.infoView = UILabel()
        self.infoView.isUserInteractionEnabled = false
        self.infoView.textColor = UIColor.stucashGrey
        self.infoView.font = UIFont.systemFont(ofSize: 15.0)
        self.infoView.numberOfLines = 0
        
        super.init(nibName: nil, bundle: nil)
        
        self.proceedButton.addTarget(self, action: #selector(proceedTapped), for: .touchUpInside)
        
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
    
    @objc private func proceedTapped() {
        proceedButton.tapped { [weak self] in
            guard let self = self else { return }
            self.interactor.requestProceed(Models.Proceed.Request())
        }
    }
    
    // MARK: PaymentDetailsDisplayLogic
    func displayInitForm(_ viewModel: PaymentDetailsModels.InitialData.ViewModel) { }
    
    func displayProceed(_ viewModel: PaymentDetailsModels.Proceed.ViewModel) {
        router.routeToProceed()
    }
    
    func displayStatusError() { }
    
    // MARK: Private
    func configureUI() {
        configureFields()
    }
    
    func configureFields() {
        self.cardImage.name = "Maksim Karablev"
        self.balanceView.text = "1337$"
        self.paymentTitle = "F%#k Homework"
        self.paymentDescription = "One homework skip"
        self.price = "322$"
        self.infoView.text = "Note: Click 'Proceed' to purchase this feature. After purchasing, it will be added to your account. To redeem goods, please show QR Code of operation to the administrator."
    }
    
    override public func viewWillLayoutSubviews() {
        modalHeaderView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(modalHeaderView)
        
        modalHeaderView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 8.0).isActive = true
        modalHeaderView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        modalHeaderView.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        modalHeaderView.heightAnchor.constraint(equalToConstant: 5.0).isActive = true
        
        cardImage.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(cardImage)
        
        cardImage.topAnchor.constraint(equalTo: modalHeaderView.topAnchor, constant: 22.0).isActive = true
        cardImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40.0).isActive = true
        cardImage.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        cardImage.widthAnchor.constraint(equalToConstant: 150.0).isActive = true
        
        balanceView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(balanceView)
        
        balanceView.topAnchor.constraint(equalTo: modalHeaderView.topAnchor, constant: 42.0).isActive = true
        balanceView.leadingAnchor.constraint(equalTo: cardImage.trailingAnchor, constant: 20.0).isActive = true
        
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(separatorView)
        
        separatorView.topAnchor.constraint(equalTo: cardImage.bottomAnchor, constant: 22.0).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        
        titleView.text = self.paymentTitle
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(titleView)
        
        titleView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 22.0).isActive = true
        titleView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0).isActive = true
        
        subtitleView.text = self.paymentDescription
        
        subtitleView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(subtitleView)
        
        subtitleView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 16.0).isActive = true
        subtitleView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0).isActive = true
        
        priceView.text = self.price
        
        priceView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(priceView)
        
        priceView.topAnchor.constraint(equalTo: subtitleView.bottomAnchor, constant: 16.0).isActive = true
        priceView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0).isActive = true
        
        infoView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(infoView)
        
        infoView.topAnchor.constraint(equalTo: priceView.bottomAnchor, constant: 22.0).isActive = true
        infoView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0).isActive = true
        infoView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0).isActive = true
        
        proceedButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(proceedButton)
        
        proceedButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -22.0).isActive = true
        proceedButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0).isActive = true
        proceedButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0).isActive = true
        proceedButton.heightAnchor.constraint(equalToConstant: 55.0).isActive = true
    }
}
