//
//  OperationDetailsInteractor.swift
//  Stucash
//
//  Created by Maksim Karaseu on 19.04.23.
//

import Foundation
import UIKit

final class OperationDetailsInteractor: OperationDetailsBusinessLogic,
                                        OperationDetailsDataStore,
                                        OperationDetailsOperationHolder {
    typealias Models = OperationDetailsModels
    typealias NetworkModels = OperationDetailsNetworkModels
    
    private let presenter: OperationDetailsPresentationLogic
    private let worker: OperationDetailsWorkerLogic
    
    private(set) var networkData: OperationDetailsNetworkDataProtocol?
    
    private(set) var operation: OperationDetailsModels.OperationItem // FIXME: перенести в бизнес(Start)
    
    init(
        presenter: OperationDetailsPresentationLogic,
        worker: OperationDetailsWorkerLogic,
        networkData: OperationDetailsNetworkDataProtocol? = nil,
        operation: OperationDetailsModels.OperationItem)
    {
        self.presenter = presenter
        self.worker = worker
        self.networkData = networkData
        self.operation = operation
    }
    
    private func loadInitForm(_ model: NetworkModels.Start.Response) {
        DispatchQueue.main.async {
            self.presenter.presentInitForm(Models.InitialData.Response(
                title: self.operation.title,
                subtitle: self.operation.desctiption,
                price: self.operation.price,
                date: self.operation.date,
                type: self.operation.type,
                activated: self.operation.activated
            ))
        }
    }
    
    private func loadRedeemStatus(_ model: NetworkModels.Redeem.Response) {
        DispatchQueue.main.async {
            self.presenter.presentRedeemStatus(Models.Redeem.Response(success: model.activated))
        }
    }
    
    private func loadStatusError() {
        self.presenter.presentStatusError()
    }
    
    // MARK: OperationDetailsBusinessLogic
    func requestInitForm(_ request: OperationDetailsModels.InitialData.Request) {
        loadInitForm(NetworkModels.Start.Response())
    }
    
    func redeem(_ request: OperationDetailsModels.Redeem.Request) {
        self.worker.redeem { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                case .success(let model):
                    self.loadRedeemStatus(model)
                case .failure:
                    self.loadStatusError()
            }
        }
    }
}
