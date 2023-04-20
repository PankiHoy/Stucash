//
//  OperationsHistoryInteractor.swift
//  Stucash
//
//  Created by Maksim Karaseu on 18.04.23.
//

import Foundation
import UIKit

final class OperationsHistoryInteractor: OperationsHistoryBusinessLogic,
                                         OperationsHistoryDataStore,
                                         OperationHistoryOperationsHolder {
    typealias Models = OperationsHistoryModels
    typealias NetworkModels = OperationsHistoryNetworkModels
    
    private let presenter: OperationsHistoryPresentationLogic
    private let worker: OperationsHistoryWorkerLogic
    
    private(set) var networkData: OperationsHistoryNetworkDataProtocol?
    
    private(set) var operations: [OperationsHistoryModels.OperationItem] = []
    
    init(
        presenter: OperationsHistoryPresentationLogic,
        worker: OperationsHistoryWorkerLogic,
        networkData: OperationsHistoryNetworkDataProtocol? = nil)
    {
        self.presenter = presenter
        self.worker = worker
        self.networkData = networkData
    }
    
    private func loadInitForm(_ model: NetworkModels.Start.Response) {
        guard let operationAction = model.actions[NetworkModels.Action.operationActionId] else { return }
        
        self.networkData?.relativeLink = operationAction.relativeLink
        
        self.operations = model.content.operations.map { item in
            return OperationsHistoryModels.OperationItem(
                operationId: item.operationId,
                title: item.title,
                description: item.description,
                price: item.price,
                date: item.date,
                type: item.type,
                activated: item.activated ?? false
            )
        }
        
        DispatchQueue.main.async {
            self.presenter.presentInitForm(Models.InitialData.Response())
        }
    }
    
    private func loadStatusError() {
        self.presenter.presentStatusError()
    }
    
    // MARK: OperationsHistoryBusinessLogic
    func requestInitForm(_ request: OperationsHistoryModels.InitialData.Request) {
        self.worker.start { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                case .success(let model):
                    self.loadInitForm(model)
                case .failure:
//                    self.loadStatusError()
                    self.loadInitForm(NetworkModels.Start.Response(
                        content: OperationsHistoryNetworkModels.Start.Content(
                            accountId: "",
                            operations: [
                                NetworkModels.Start.Content.Operation(
                                    operationId: "1",
                                    title: "Transfer To Account",
                                    description: "Transfered 16 stucash to 'DMITRIY'",
                                    price: -16,
                                    date: Date(),
                                    type: "transfer"
                                ),
                                NetworkModels.Start.Content.Operation(
                                    operationId: "2",
                                    title: "F%#k Homework",
                                    description: "Purchased one homework skip",
                                    price: -322,
                                    date: Date(),
                                    type: "buy",
                                    activated: true
                                ),
                                NetworkModels.Start.Content.Operation(
                                    operationId: "3",
                                    title: "Sleeping Time",
                                    description: "Purchased the right to sleep during lesson",
                                    price: -228,
                                    date: Date(),
                                    type: "buy",
                                    activated: false
                                ),
                                NetworkModels.Start.Content.Operation(
                                    operationId: "4",
                                    title: "The King Is Dead Long Live The King",
                                    description: "A day OFF from school",
                                    price: -1488,
                                    date: Date(),
                                    type: "buy",
                                    activated: false
                                ),
                                NetworkModels.Start.Content.Operation(
                                    operationId: "5",
                                    title: "It's Nice To Be Nice",
                                    description: "Checked out for 300 stucash for good behaviour",
                                    price: +300,
                                    date: Date(),
                                    type: "income"
                                ),
                                NetworkModels.Start.Content.Operation(
                                    operationId: "6",
                                    title: "I Hate Everything About You",
                                    description: "Absence",
                                    price: -666,
                                    date: Date(),
                                    type: "buy",
                                    activated: true
                                ),
                                NetworkModels.Start.Content.Operation(
                                    operationId: "7",
                                    title: "Money Can't Buy Happiness, Or Can It..",
                                    description: "Purchased dinner at the canteen",
                                    price: -911,
                                    date: Date(),
                                    type: "buy",
                                    activated: true
                                ),
                                NetworkModels.Start.Content.Operation(
                                    operationId: "8",
                                    title: "Never Wanted To Dance",
                                    description: "A right to skip the prom",
                                    price: -1337,
                                    date: Date(),
                                    type: "buy",
                                    activated: false
                                )
                            ]),
                        actions: ["operation-details" : NetworkModels.Action(
                            title: "",
                            relativeLink: "",
                            httpMethod: ""
                        )]
                    ))
            }
        }
    }
    
    func didTapOperation(_ request: OperationsHistoryModels.OperationAction.Request) { }
}
