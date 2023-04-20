//
//  QRReederPresenter.swift
//  Stucash
//
//  Created by Maksim Karaseu on 19.04.23.
//

import Foundation

final class QRReaderPresenter: QRReaderPresentationLogic {
    typealias Models = QRReaderModels
    
    weak var viewController: QRReaderDisplayLogic?
    
    // MARK: QRReaderPresentationLogic
    func presentInitForm(_ response: Models.InitialData.Response) {
        viewController?.displayInitForm(Models.InitialData.ViewModel())
    }
    
    func presentAmountSelection(_ response: Models.AmountSelection.Response) {
        viewController?.displayAmountSelection(Models.AmountSelection.ViewModel())
    }
    
    func presentRedeem(_ response: Models.Redeem.Response) {
        viewController?.displayRedeem(Models.Redeem.ViewModel())
    }
    
    func presentStatusError() {
        viewController?.displayStatusError()
    }
}
