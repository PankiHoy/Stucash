//
//  AmountSelectionProtocols.swift
//  Stucash
//
//  Created by Maksim Karaseu on 19.04.23.
//

protocol AmountSelectionBusinessLogic {
    func requestInitForm(_ request: AmountSelectionModels.InitialData.Request)
    func requestTransaction(_ request: AmountSelectionModels.Transaction.Request)
}

protocol AmountSelectionRoutingLogic {
    func routeToTransaction()
    func routeBack()
}

protocol AmountSelectionDataStore {
    var networkData: AmountSelectionNetworkDataProtocol? { get }
}

protocol AmountSelectionDisplayLogic: AnyObject {
    func displayInitForm(_ viewModel: AmountSelectionModels.InitialData.ViewModel)
    func displayTransaction(_ viewModel: AmountSelectionModels.Transaction.ViewModel)
}

protocol AmountSelectionPresentationLogic {
    func presentInitForm(_ response: AmountSelectionModels.InitialData.Response)
    func presentTransaction(_ response: AmountSelectionModels.Transaction.Response)
}

protocol AmountSelectionWorkerLogic {
    var networkData: AmountSelectionNetworkDataProtocol { get }
    func checkServiceAvailability(
        completion: ((Result<AmountSelectionNetworkModels.CheckServiceAvailability.Response, AmountSelectionNetworkModels.Failure>) -> Void)?
    )
    func transaction(amount: Int64, completion: ((Result<AmountSelectionNetworkModels.Transaction.Response, AmountSelectionNetworkModels.Failure>) -> Void)?)
}
