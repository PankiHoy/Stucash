//
//  OperationsHistoryPresenter.swift
//  Stucash
//
//  Created by Maksim Karaseu on 18.04.23.
//

import UIKit

final class OperationsHistoryPresenter: OperationsHistoryPresentationLogic {
    typealias Models = OperationsHistoryModels
    
    weak var viewController: OperationsHistoryDisplayLogic?
    
    // MARK: OperationsHistoryPresentationLogic
    func presentInitForm(_ response: OperationsHistoryModels.InitialData.Response) {
        viewController?.displayInitForm(Models.InitialData.ViewModel())
    }
    
    func presentStatusError() {
        viewController?.displayStatusError()
    }
}
