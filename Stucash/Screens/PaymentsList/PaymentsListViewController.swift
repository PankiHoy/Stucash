//
//  PaymentsListViewController.swift
//  Stucash
//
//  Created by Maksim Karaseu on 18.04.23.
//

import Foundation
import UIKit

final class PaymentsListViewController: UIViewController,
                                        PaymentsListDisplayLogic {
    typealias Models = PaymentsListModels
    
    private let interactor: PaymentsListBusinessLogic & PaymentsListPaymentsHolder
    private let router: PaymetsListRoutingLogic
    
    private let cardImage: SmallCardView
    private let balanceView: UILabel
    private let footerView: UILabel
    
    private lazy var paymentsTable: StucashTableView = {
        let view = StucashTableView()
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = UIColor.stucashBlack
        view.separatorStyle = .singleLine
        view.separatorColor = UIColor.stucashGold
        view.isScrollEnabled = false
        
        return view
    }()
    
    private let scrollContentView: UIView = UIView()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        return scrollView
    }()
    
    init(
        interactor: PaymentsListBusinessLogic & PaymentsListPaymentsHolder,
        router: PaymetsListRoutingLogic
    ) {
        self.interactor = interactor
        self.router = router
        
        self.cardImage = SmallCardView()
        self.cardImage.isUserInteractionEnabled = false
        self.cardImage.backgroundColor = UIColor.stucashGold
        self.cardImage.layer.cornerRadius = 12.0
        
        self.balanceView = UILabel()
        self.balanceView.isUserInteractionEnabled = false
        self.balanceView.textColor = UIColor.stucashWhite
        self.balanceView.font = UIFont.stucashRegular(ofSize: 55.0)
        
        self.footerView = UILabel()
        self.footerView.isUserInteractionEnabled = false
        self.footerView.textColor = UIColor.stucashGold
        self.footerView.font = UIFont.systemFont(ofSize: 14.0)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initForm()
        
        self.view.backgroundColor = UIColor.stucashBlack
        self.title = "Payments"
        self.navigationController?.isNavigationBarHidden = false
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.stucashBlack
        appearance.titleTextAttributes = [.foregroundColor : UIColor.stucashGold ?? UIColor.white]
        self.navigationController?.navigationBar.standardAppearance = appearance
    }
    
    // MARK: PaymentsListDisplayLogic
    func displayInitForm(_ viewModel: PaymentsListModels.InitialData.ViewModel) {
        stopShimmer()
        paymentsTable.reloadData()
    }
    
    func displayStatusError() {
        router.routeToStatusErrorScene()
    }
    
    // MARK: Private
    private func initForm() {
        configureUI()
        startShimmer()
        self.interactor.requestInitForm(Models.InitialData.Request())
    }
    
    private func configureUI() {
        configureFields()
        configurePaymentsTable()
    }
    
    private func configureFields() {
        cardImage.name = "Maksim Karablev"
        balanceView.text = "1337$"
        footerView.text = "More features coming soon.."
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        
        scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        scrollContentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(scrollContentView)
        
        scrollContentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16.0).isActive = true
        scrollContentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16.0).isActive = true
        scrollContentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16.0).isActive = true
        scrollContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16.0).isActive = true
        scrollContentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -16.0 - 16.0).isActive = true
        scrollContentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, constant: 60.0).isActive = true
        
        cardImage.translatesAutoresizingMaskIntoConstraints = false
        scrollContentView.addSubview(cardImage)
                
        cardImage.topAnchor.constraint(equalTo: scrollContentView.topAnchor, constant: 5.0).isActive = true
        cardImage.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 40.0).isActive = true
        cardImage.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        cardImage.widthAnchor.constraint(equalToConstant: 150.0).isActive = true
        
        balanceView.translatesAutoresizingMaskIntoConstraints = false
        scrollContentView.addSubview(balanceView)
        
        balanceView.topAnchor.constraint(equalTo: scrollContentView.topAnchor, constant: 25.0).isActive = true
        balanceView.leadingAnchor.constraint(equalTo: cardImage.trailingAnchor, constant: 20.0).isActive = true
        
        paymentsTable.translatesAutoresizingMaskIntoConstraints = false
        scrollContentView.addSubview(paymentsTable)
        
        paymentsTable.topAnchor.constraint(equalTo: cardImage.bottomAnchor, constant: 30.0).isActive = true
        paymentsTable.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor).isActive = true
        paymentsTable.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor).isActive = true
        
        footerView.translatesAutoresizingMaskIntoConstraints = false
        scrollContentView.addSubview(footerView)
        
        footerView.topAnchor.constraint(equalTo: paymentsTable.bottomAnchor, constant: 16.0).isActive = true
        footerView.centerXAnchor.constraint(equalTo: scrollContentView.centerXAnchor).isActive = true
    }
    
    private func configurePaymentsTable() {
        paymentsTable.delegate = self
        paymentsTable.dataSource = self
        paymentsTable.register(PaymentCell.self, forCellReuseIdentifier: PaymentCell.identifier)
    }
    
    private func startShimmer() { }
    
    private func stopShimmer() { }
}

extension PaymentsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let paymentId = self.interactor.payments[indexPath.row].paymentId
        router.routeToPaymentDetailsScene(paymentId: paymentId)
    }
}

extension PaymentsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.interactor.payments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let payment = self.interactor.payments[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: PaymentCell.identifier) as? PaymentCell
        cell?.selectionStyle = .none
        cell?.title = payment.title
        cell?.subtitle = payment.description
        cell?.price = String(payment.price)
        
        return cell!
    }
}
