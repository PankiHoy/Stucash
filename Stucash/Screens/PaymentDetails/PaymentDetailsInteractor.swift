//
//  PaymentDetailsInteractor.swift
//  Stucash
//
//  Created by Maksim Karaseu on 20.04.23.
//

import Foundation

final class PaymentDetailsInteractor: PaymentDetailsBusinessLogic,
                                      PaymentDetailsDataStore {
    typealias Models = PaymentDetailsModels
    typealias NetworkModels = PaymentDetailsNetworkModels
    
    private let presenter: PaymentDetailsPresentationLogic
    private let worker: PaymentDetailsWorkerLogic
    
    private(set) var networkData: PaymentDetailsNetworkDataProtocol?
    
    init(
        presenter: PaymentDetailsPresentationLogic,
        worker: PaymentDetailsWorkerLogic,
        networkData: PaymentDetailsNetworkDataProtocol? = nil
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
    
    private func loadProceed(_ model: NetworkModels.Proceed.Response) {
        DispatchQueue.main.async {
            self.presenter.presentProceed(Models.Proceed.Response())
        }
    }
    
    private func loadStatusError() {
        DispatchQueue.main.async {
            self.presenter.presentStatusError()
        }
    }
    
    // MARK: PaymentDetailsBusinessLogic
    func requestInitForm(_ request: PaymentDetailsModels.InitialData.Request) {
        loadInitForm(NetworkModels.Start.Response())
    }
    
    func requestProceed(_ request: PaymentDetailsModels.Proceed.Request) {
        worker.proceed { [weak self] response in
            guard let self = self else { return }
            
            switch response {
                case .success(let model):
                    self.loadProceed(model)
                case .failure:
                    self.loadStatusError()
            }
        }
    }
}
