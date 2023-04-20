//
//  QRReederProtocols.swift
//  Stucash
//
//  Created by Maksim Karaseu on 19.04.23.
//

import UIKit

protocol QRReaderBusinessLogic {
    func requestInitForm(_ request: QRReaderModels.InitialData.Request)
    func requestActionByQRCode(_ request: QRReaderModels.QRAction.Request)
}

protocol QRReaderRoutingLogic {
    func routeToAmountSelection()
    func routeBack()
}

protocol QRReaderDataStore {
    var networkData: QRReaderNetworkDataProtocol? { get }
}

protocol QRReaderDisplayLogic: AnyObject {
    func displayInitForm(_ viewModel: QRReaderModels.InitialData.ViewModel)
    func displayAmountSelection(_ viewModel: QRReaderModels.AmountSelection.ViewModel)
    func displayRedeem(_ viewModel: QRReaderModels.Redeem.ViewModel)
    func displayStatusError()
}

protocol QRReaderPresentationLogic {
    func presentInitForm(_ response: QRReaderModels.InitialData.Response)
    func presentAmountSelection(_ response: QRReaderModels.AmountSelection.Response)
    func presentRedeem(_ response: QRReaderModels.Redeem.Response)
    func presentStatusError()
}

protocol QRReaderWorkerLogic {
    var networkData: QRReaderNetworkDataProtocol { get }
    func checkServiceAvailability(
        completion: ((Result<QRReaderNetworkModels.CheckServiceAvailability.Response, QRReaderNetworkModels.Failure>) -> Void)?
    )
    func redeem(operationId: String, completion: ((Result<QRReaderNetworkModels.Redeem.Response, QRReaderNetworkModels.Failure>) -> Void)?)
}
