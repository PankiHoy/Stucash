//
//  CardShowcaseViewController.swift
//  Stucash
//
//  Created by Maksim Karaseu on 16.04.23.
//

import Foundation
import UIKit

final class CardShowcaseViewController: UIViewController,
                                        CardShowcaseDisplayLogic {
    typealias Models = CardShowcaseModels
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM hh:mm"
        
        return dateFormatter
    }()
    
    private let interactor: CardShowcaseBusinessLogic & CardShowcaseOperationHolder
    private let router: CardShowcaseRoutingLogic

    private let cardImageView: CardView = CardView()
    
    private lazy var transferButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = UIColor.stucashGrey
        button.setTitle("Transfer Stucash", for: .normal)
        button.setTitleColor(UIColor.stucashDarkGold, for: .normal)
        button.titleLabel?.attributedText = NSAttributedString(
            string: "Transfer Stucash",
            attributes: [
                .font : UIFont.stucashRegular(ofSize: 20.0),
                .kern : 2.0
            ]
        )
        button.titleLabel?.textAlignment = .center
        
        return button
    }()
    
    private lazy var operationsView: StucashTableView = {
        let view =  StucashTableView()
        view.showsVerticalScrollIndicator = false
        view.isScrollEnabled = false
        view.backgroundColor = UIColor.stucashBlack
        view.layer.borderColor = UIColor.stucashGold?.cgColor
        view.layer.borderWidth = 1.0
        view.separatorColor = UIColor.stucashGold
        
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
        interactor: CardShowcaseBusinessLogic & CardShowcaseOperationHolder,
        router: CardShowcaseRoutingLogic
    ) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    @available (*, unavailable)
    required init(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initForm()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @objc private func transferTapped() {
        transferButton.tapped { [weak self] in
            guard let self = self else { return }
            self.router.routeToTransactionScene()
        }
    }
    
    // MARK: CardShowcaseDisplayLogic
    func displayInitForm(_ viewModel: Models.InitialData.ViewModel) {
        stopShimmer()
        cardImageView.name = viewModel.userName
        cardImageView.surname = viewModel.userSurname
        cardImageView.icon = "stucash"
        cardImageView.balance = viewModel.balance
        operationsView.reloadData()
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
        configureTransfer()
        configureOperationsTable()
        configureScroll()
        self.view.backgroundColor = UIColor.stucashBlack
    }
    
    private func configureFields() {
        
    }
    
    override func viewWillLayoutSubviews() {
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
        
        cardImageView.translatesAutoresizingMaskIntoConstraints = false
        scrollContentView.addSubview(cardImageView)
        
        cardImageView.topAnchor.constraint(equalTo: scrollContentView.topAnchor).isActive = true
        cardImageView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor).isActive = true
        cardImageView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor).isActive = true
        cardImageView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 16.0 - 16.0) / 1.618).isActive = true
        
        transferButton.translatesAutoresizingMaskIntoConstraints = false
        scrollContentView.addSubview(transferButton)
        
        transferButton.topAnchor.constraint(equalTo: cardImageView.bottomAnchor, constant: 16.0).isActive = true
        transferButton.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 4.0).isActive = true
        transferButton.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -4.0).isActive = true
        transferButton.heightAnchor.constraint(equalToConstant: 55.0).isActive = true
        transferButton.layer.cornerRadius = 6.0
        
        operationsView.translatesAutoresizingMaskIntoConstraints = false
        scrollContentView.addSubview(operationsView)
        
        operationsView.topAnchor.constraint(equalTo: transferButton.bottomAnchor, constant: 16.0).isActive = true
        operationsView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor).isActive = true
        operationsView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor).isActive = true
        operationsView.layer.cornerRadius = 12.0
    }
    
    private func configureTransfer() {
        transferButton.addTarget(self, action: #selector(transferTapped), for: .touchUpInside)
    }
    
    private func configureOperationsTable() {
        operationsView.delegate = self
        operationsView.dataSource = self
        operationsView.register(OperationCell.self, forCellReuseIdentifier: OperationCell.identifier)
    }
    
    private func configureScroll() {
        scrollView.delegate = self
        scrollView.alwaysBounceVertical = true
    }
    
    private func startShimmer() { }
    
    private func stopShimmer() { }
}

extension CardShowcaseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let operation = self.interactor.operations[indexPath.row]
        router.routeToOperationDetailsScene(operationId: operation.operationId)
    }
}

extension CardShowcaseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        65.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.interactor.operations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let operation = self.interactor.operations[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: OperationCell.identifier) as? OperationCell
        cell?.title = operation.title
        cell?.subtitle = operation.description
        cell?.balance = (operation.price > 0 ? "+" : "") + "\(operation.price)"
        cell?.date = self.dateFormatter.string(from: operation.date)
        cell?.type = OperationType.operationByValue(operation.type) ?? .buy
        cell?.activated = operation.activated
        cell?.selectionStyle = .none
        
        return cell!
    }
}

extension CardShowcaseViewController: UIScrollViewDelegate { }
