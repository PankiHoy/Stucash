//
//  PaymentsListPresenter.swift
//  Stucash
//
//  Created by Maksim Karaseu on 18.04.23.
//

import UIKit

final class PaymentsListPresenter: PaymentsListPresentationLogic {
    typealias Models = PaymentsListModels
    
    weak var viewController: PaymentsListDisplayLogic?
    
    // MARK: PaymentsListPresentationLogic
    func presentInitForm(_ response: PaymentsListModels.InitialData.Response) {
        viewController?.displayInitForm(Models.InitialData.ViewModel())
    }
    
    func presentStatusError() {
        viewController?.displayStatusError()
    }
}
