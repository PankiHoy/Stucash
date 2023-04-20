//
//  CardShowcaseRouter.swift
//  Stucash
//
//  Created by Maksim Karaseu on 16.04.23.
//

import UIKit

final class CardShowcaseRouter: CardShowcaseRoutingLogic {
    weak var viewController: UIViewController?
    
    private let dataStore: CardShowcaseDataStore & CardShowcaseOperationHolder
    
    init(dataStore: CardShowcaseDataStore & CardShowcaseOperationHolder) {
        self.dataStore = dataStore
    }
    
    func routeToCardScene() { }
    
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
    
    func routeToTransactionScene() {
        let controller = QRReaderSceneAssembly.build(networkData: QRReaderNetworkData(
            accountId: "",
            recieverId: "",
            relativeLink: ""
        ))
        viewController?.navigationController?.pushViewController(controller, animated: true)
    }
    
    func routeToStatusErrorScene() { }
    
    func routeBack() { }
}
