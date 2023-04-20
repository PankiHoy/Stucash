//
//  CardShocaseProcotols.swift
//  Stucash
//
//  Created by Maksim Karaseu on 16.04.23.
//

import UIKit

protocol CardShowcaseOperationHolder {
    var operations: [CardShowcaseModels.OperationItem] { get }
}

protocol CardShowcaseBusinessLogic {
    func requestInitForm(_ request: CardShowcaseModels.InitialData.Request)
    func didTapCard(_ request: CardShowcaseModels.CardAction.Request)
}

protocol CardShowcaseRoutingLogic {
    func routeToCardScene()
    func routeToOperationDetailsScene(operationId: String)
    func routeToTransactionScene()
    func routeToStatusErrorScene()
    func routeBack()
}

protocol CardShowcaseDataStore {
    var networkData: CardShowcaseNetworkDataProtocol? { get }
}

protocol CardShowcaseDisplayLogic: AnyObject {
    func displayInitForm(_ viewModel: CardShowcaseModels.InitialData.ViewModel)
    func displayStatusError()
}

protocol CardShowcasePresentationLogic {
    func presentInitForm(_ response: CardShowcaseModels.InitialData.Response)
    func presentStatusError()
}

protocol CardShowcaseWorkerLogic {
    var networkData: CardShowcaseNetworkDataProtocol { get }
    func checkServiceAvailability(
        completion: ((Result<CardShowcaseNetworkModels.CheckServiceAvailability.Response, CardShowcaseNetworkModels.Failure>) -> Void)?
    )
    func start(completion: ((Result<CardShowcaseNetworkModels.Start.Response, CardShowcaseNetworkModels.Failure>) -> Void)?)
}
