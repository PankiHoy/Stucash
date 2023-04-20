//
//  PaymentsListProtocols.swift
//  Stucash
//
//  Created by Maksim Karaseu on 18.04.23.
//

import UIKit

protocol PaymentsListBusinessLogic {
    func requestInitForm(_ request: PaymentsListModels.InitialData.Request)
    func didTapPayment(_ request: PaymentsListModels.PaymentAction.Request)
}

protocol PaymetsListRoutingLogic {
    func routeToPaymentDetailsScene(paymentId: String)
    func routeToStatusErrorScene()
}

protocol PaymentsListDataStore {
    var networkData: PaymentsListNetworkDataProtocol? { get }
}

protocol PaymentsListPaymentsHolder {
    var payments: [PaymentsListModels.PaymentItem] { get }
}

protocol PaymentsListDisplayLogic: AnyObject {
    func displayInitForm(_ viewModel: PaymentsListModels.InitialData.ViewModel)
    func displayStatusError()
}

protocol PaymentsListPresentationLogic {
    func presentInitForm(_ response: PaymentsListModels.InitialData.Response)
    func presentStatusError()
}

protocol PaymentsListWorkerLogic {
    var networkData: PaymentsListNetworkDataProtocol { get }
    func checkServiceAvailability(
        completion: ((Result<PaymentsListNetworkModels.CheckServiceAvailability.Response, PaymentsListNetworkModels.Failure>) -> Void)?
    )
    func start(completion: ((Result<PaymentsListNetworkModels.Start.Response, PaymentsListNetworkModels.Failure>) -> Void)?)
}
