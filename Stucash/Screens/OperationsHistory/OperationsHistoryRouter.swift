//
//  OperationsHistoryRouter.swift
//  Stucash
//
//  Created by Maksim Karaseu on 18.04.23.
//

import UIKit

final class OperationsHistoryRouter: OperationsHistoryRoutingLogic {
    weak var viewController: UIViewController?
    
    private let dataStore: OperationsHistoryDataStore & OperationHistoryOperationsHolder
    
    init(dataStore: OperationsHistoryDataStore & OperationHistoryOperationsHolder) {
        self.dataStore = dataStore
    }
    
    func routeToOperationDetailsScene(operationId: String) {
        guard let operation = dataStore.operations.first(where: { $0.operationId == operationId }) else { return }
        
        let controller = OperationDetailsAssembly.build(
            networkData: OperationDetailsNetworkData(
                accountId: dataStore.networkData?.accountId ?? "",
                operationId: operationId,
                relativeLink: dataStore.networkData?.relativeLink
            ),
            operation: OperationDetailsModels.OperationItem(
                operationId: operationId,
                title: operation.title,
                desctiption: operation.description,
                price: operation.price,
                date: operation.date,
                type: operation.type,
                activated: operation.activated
            )
        )
        viewController?.present(controller, animated: true)
    }
    
    func routeToStatusErrorScene() { }
}
