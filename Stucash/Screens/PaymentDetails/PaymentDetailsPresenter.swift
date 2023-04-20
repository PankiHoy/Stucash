//
//  PaymentDetailsPresenter.swift
//  Stucash
//
//  Created by Maksim Karaseu on 20.04.23.
//

final class PaymentDetailsPresenter: PaymentDetailsPresentationLogic {
    typealias Models = PaymentDetailsModels
    
    weak var viewController: PaymentDetailsDisplayLogic?
    
    //MARK: PaymentDetailsPresentationLogic
    func presentInitForm(_ response: Models.InitialData.Response) {
        viewController?.displayInitForm(Models.InitialData.ViewModel())
    }
    
    func presentProceed(_ response: Models.Proceed.Response) {
        viewController?.displayProceed(Models.Proceed.ViewModel())
    }
    
    func presentStatusError() {
        viewController?.displayStatusError()
    }
}
