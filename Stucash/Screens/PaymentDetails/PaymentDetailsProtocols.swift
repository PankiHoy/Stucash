//
//  PaymentDetailsProtocols.swift
//  Stucash
//
//  Created by Maksim Karaseu on 20.04.23.
//

protocol PaymentDetailsBusinessLogic {
    func requestInitForm(_ request: PaymentDetailsModels.InitialData.Request)
    func requestProceed(_ request: PaymentDetailsModels.Proceed.Request)
}

protocol PaymentDetailsRoutingLogic {
    func routeToProceed()
    func routeBack()
}

protocol PaymentDetailsDataStore {
    var networkData: PaymentDetailsNetworkDataProtocol? { get }
}

protocol PaymentDetailsDisplayLogic: AnyObject {
    func displayInitForm(_ viewModel: PaymentDetailsModels.InitialData.ViewModel)
    func displayProceed(_ viewModel: PaymentDetailsModels.Proceed.ViewModel)
    func displayStatusError()
}

protocol PaymentDetailsPresentationLogic {
    func presentInitForm(_ response: PaymentDetailsModels.InitialData.Response)
    func presentProceed(_ response: PaymentDetailsModels.Proceed.Response)
    func presentStatusError()
}

protocol PaymentDetailsWorkerLogic {
    var networkData: PaymentDetailsNetworkDataProtocol { get }
    func checkServiceAvailability(
        completion: ((Result<PaymentDetailsNetworkModels.CheckServiceAvailability.Response, PaymentDetailsNetworkModels.Failure>) -> Void)?
    )
    func proceed(completion: ((Result<PaymentDetailsNetworkModels.Proceed.Response, PaymentDetailsNetworkModels.Failure>) -> Void)?)
}
