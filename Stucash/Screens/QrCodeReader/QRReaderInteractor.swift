//
//  QRReederInteractor.swift
//  Stucash
//
//  Created by Maksim Karaseu on 19.04.23.
//

import Foundation

final class QRReaderInteractor: QRReaderBusinessLogic,
                                QRReaderDataStore {
    typealias Models = QRReaderModels
    typealias NetworkModels = QRReaderNetworkModels
    
    private let presenter: QRReaderPresentationLogic
    private let worker: QRReaderWorkerLogic
    
    private(set) var networkData: QRReaderNetworkDataProtocol?
    
    init(
        presenter: QRReaderPresentationLogic,
        worker: QRReaderWorkerLogic,
        networkData: QRReaderNetworkDataProtocol? = nil
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
    
    private func loadAmountSelection(_ model: NetworkModels.AmountSelection.Response) {
        self.networkData?.recieverId = model.recieverId
        
        DispatchQueue.main.async {
            self.presenter.presentAmountSelection(Models.AmountSelection.Response())
        }
    }
    
    private func loadRedeem(_ model: NetworkModels.Redeem.Response) {
        DispatchQueue.main.async {
            self.presenter.presentRedeem(Models.Redeem.Response())
        }
    }
    
    private func loadStatusError() {
        DispatchQueue.main.async {
            self.presenter.presentStatusError()
        }
    }
    
    // MARK: QRReaderBusinessLogic
    func requestInitForm(_ request: Models.InitialData.Request) {
        loadInitForm(NetworkModels.Start.Response())
    }
    
    func requestActionByQRCode(_ request: Models.QRAction.Request) {
        if request.string == "operationId" {
            worker.redeem(operationId: request.string) { [weak self] response in
                guard let self = self else { return }
                
                switch response {
                    case .success(let model):
                        self.loadRedeem(model)
                    case .failure:
                        self.loadStatusError()
                }
            }
            
        } else if request.string == "recieverId\n" {
            self.loadAmountSelection(NetworkModels.AmountSelection.Response(recieverId: request.string))
        }
    }
}
