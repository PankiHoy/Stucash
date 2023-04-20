//
//  OperationDetailsProtocols.swift
//  Stucash
//
//  Created by Maksim Karaseu on 19.04.23.
//

import UIKit

protocol OperationDetailsBusinessLogic {
    func requestInitForm(_ request: OperationDetailsModels.InitialData.Request)
    func redeem(_ request: OperationDetailsModels.Redeem.Request)
}

protocol OperationDetailsRoutingLogic {
    func routeBack()
}

protocol OperationDetailsDataStore {
    var networkData: OperationDetailsNetworkDataProtocol? { get }
}

protocol OperationDetailsOperationHolder {
    var operation: OperationDetailsModels.OperationItem { get }
}

protocol OperationDetailsDisplayLogic: AnyObject {
    func displayInitForm(_ viewModel: OperationDetailsModels.InitialData.ViewModel)
    func displayRedeemStatus(_ viewModel: OperationDetailsModels.Redeem.ViewModel)
    func displayStatusError()
}

protocol OperationDetailsPresentationLogic {
    func presentInitForm(_ response: OperationDetailsModels.InitialData.Response)
    func presentRedeemStatus(_ response: OperationDetailsModels.Redeem.Response)
    func presentStatusError()
}

protocol OperationDetailsWorkerLogic {
    var networkData: OperationDetailsNetworkDataProtocol { get }
    func checkServiceAvailability(
        completion: ((Result<CardShowcaseNetworkModels.CheckServiceAvailability.Response, CardShowcaseNetworkModels.Failure>) -> Void)?
    )
    func redeem(completion: ((Result<OperationDetailsNetworkModels.Redeem.Response, OperationDetailsNetworkModels.Failure>) -> Void)?)
}
