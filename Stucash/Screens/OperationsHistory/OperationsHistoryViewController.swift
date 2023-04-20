//
//  OperationsHistoryViewController.swift
//  Stucash
//
//  Created by Maksim Karaseu on 18.04.23.
//

import Foundation
import UIKit

final class OperationsHistoryViewController: UIViewController,
                                             OperationsHistoryDisplayLogic {
    typealias Models = OperationsHistoryModels
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM hh:mm"
        
        return dateFormatter
    }()
    
    private let interactor: OperationsHistoryBusinessLogic & OperationHistoryOperationsHolder
    private let router: OperationsHistoryRoutingLogic
    
    private lazy var operationsTable: StucashTableView = {
        let view = StucashTableView()
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = UIColor.stucashBlack
        view.separatorColor = UIColor.stucashGold
        
        return view
    }()
    
    init(
        interactor: OperationsHistoryBusinessLogic & OperationHistoryOperationsHolder,
        router: OperationsHistoryRoutingLogic
    ) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initForm()
        
        self.view.backgroundColor = UIColor.stucashBlack
        self.title = "History"
        self.navigationController?.isNavigationBarHidden = false
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.stucashBlack
        appearance.titleTextAttributes = [.foregroundColor : UIColor.stucashGold ?? UIColor.white]
        self.navigationController?.navigationBar.standardAppearance = appearance
        
    }
    
    // MARK: OperationsHistoryDisplayLogic
    func displayInitForm(_ viewModel: OperationsHistoryModels.InitialData.ViewModel) {
        stopShimmer()
        operationsTable.reloadData()
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
        configureOperationsTable()
    }
    
    private func configureFields() {
        
    }
    
    override public func viewDidLayoutSubviews() {
        operationsTable.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(operationsTable)
        
        operationsTable.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        operationsTable.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        operationsTable.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        operationsTable.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func configureOperationsTable() {
        operationsTable.delegate = self
        operationsTable.dataSource = self
        operationsTable.register(OperationCell.self, forCellReuseIdentifier: OperationCell.identifier)
    }
    
    private func startShimmer() { }
    
    private func stopShimmer() { }
}

extension OperationsHistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let operation = self.interactor.operations[indexPath.row]
        router.routeToOperationDetailsScene(operationId: operation.operationId)
    }
}

extension OperationsHistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.interactor.operations.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let operation = self.interactor.operations[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: OperationCell.identifier) as? OperationCell
        cell?.title = operation.title
        cell?.subtitle = operation.description
        cell?.balance = (operation.price > 0 ? "+" : "") + "\(operation.price)"
        cell?.date = dateFormatter.string(from: operation.date)
        cell?.type = OperationType.operationByValue(operation.type)
        cell?.activated = operation.activated
        cell?.selectionStyle = .none
        
        return cell!
    }
}
