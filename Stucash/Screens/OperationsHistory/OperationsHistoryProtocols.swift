//
//  OperationsHistoryProcols.swift
//  Stucash
//
//  Created by Maksim Karaseu on 18.04.23.
//

import UIKit

protocol OperationsHistoryBusinessLogic {
    func requestInitForm(_ request: OperationsHistoryModels.InitialData.Request)
    func didTapOperation(_ request: OperationsHistoryModels.OperationAction.Request)
}

protocol OperationsHistoryRoutingLogic {
    func routeToOperationDetailsScene(operationId: String)
    func routeToStatusErrorScene()
}

protocol OperationsHistoryDataStore {
    var networkData: OperationsHistoryNetworkDataProtocol? { get }
}

protocol OperationHistoryOperationsHolder {
    var operations: [OperationsHistoryModels.OperationItem] { get }
}

protocol OperationsHistoryDisplayLogic: AnyObject {
    func displayInitForm(_ viewModel: OperationsHistoryModels.InitialData.ViewModel)
    func displayStatusError()
}

protocol OperationsHistoryPresentationLogic {
    func presentInitForm(_ response: OperationsHistoryModels.InitialData.Response)
    func presentStatusError()
}

protocol OperationsHistoryWorkerLogic {
    var networkData: OperationsHistoryNetworkDataProtocol { get }
    func checkServiceAvailability(
        completion: ((Result<OperationsHistoryNetworkModels.CheckServiceAvailability.Response, CardShowcaseNetworkModels.Failure>) -> Void)?
    )
    func start(completion: ((Result<OperationsHistoryNetworkModels.Start.Response, CardShowcaseNetworkModels.Failure>) -> Void)?)
}
