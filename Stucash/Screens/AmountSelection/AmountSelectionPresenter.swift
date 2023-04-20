//
//  AmountSelectionPresenter.swift
//  Stucash
//
//  Created by Maksim Karaseu on 19.04.23.
//

final class AmountSelectionPresenter: AmountSelectionPresentationLogic {
    typealias Models = AmountSelectionModels
    
    weak var viewController: AmountSelectionDisplayLogic?
    
    // MARK: AmountSelectionPresentationLogic
    func presentInitForm(_ response: Models.InitialData.Response) {
        viewController?.displayInitForm(Models.InitialData.ViewModel())
    }
    
    func presentTransaction(_ response: AmountSelectionModels.Transaction.Response) {
        viewController?.displayTransaction(Models.Transaction.ViewModel())
    }
}
