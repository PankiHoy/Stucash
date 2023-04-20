//
//  AmountSelectionInteractor.swift
//  Stucash
//
//  Created by Maksim Karaseu on 19.04.23.
//

import Foundation

final class AmountSelectionInteractor: AmountSelectionBusinessLogic,
                                       AmountSelectionDataStore {
    typealias Models = AmountSelectionModels
    typealias NetworkModels = AmountSelectionNetworkModels
    
    private let presenter: AmountSelectionPresentationLogic
    private let worker: AmountSelectionWorkerLogic
    
    private(set) var networkData: AmountSelectionNetworkDataProtocol?
    
    init(
        presenter: AmountSelectionPresentationLogic,
        worker: AmountSelectionWorkerLogic,
        networkData: AmountSelectionNetworkDataProtocol? = nil
    ) {
        self.presenter = presenter
        self.worker = worker
        self.networkData = networkData
    }
    
    private func loadInitForm(_ model: NetworkModels.Start.Response) {
        DispatchQueue.main.async {
            self.presenter.presentInitForm(Models.InitialData.Response())
        }
    }
    
    private func loadTransaction(_ model: NetworkModels.Transaction.Response) {
        DispatchQueue.main.async {
            self.presenter.presentTransaction(Models.Transaction.Response())
        }
    }
    
    // MARK: AmountSelectionBusinessLogic
    func requestInitForm(_ request: AmountSelectionModels.InitialData.Request) {
        loadInitForm(NetworkModels.Start.Response())
    }
    
    func requestTransaction(_ request: AmountSelectionModels.Transaction.Request) {
        worker.transaction(amount: request.sum) { _ in }
    }
}


