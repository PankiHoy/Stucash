//
//  OperationDetailsPresenter.swift
//  Stucash
//
//  Created by Maksim Karaseu on 19.04.23.
//

import UIKit

final class OperationDetailsPresenter: OperationDetailsPresentationLogic {
    typealias Models = OperationDetailsModels
    
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM hh:mm"
        
        return dateFormatter
    }()
    
    weak var viewController: OperationDetailsDisplayLogic?
    
    // MARK: OperationDetailsPresentationLogic
    func presentInitForm(_ response: OperationDetailsModels.InitialData.Response) {
        viewController?.displayInitForm(Models.InitialData.ViewModel(
            title: response.title,
            subtitle: response.subtitle,
            price: (response.price > 0 ? "+" : "") + "\(response.price)",
            pricePostitive: response.price > 0,
            date: dateFormatter.string(from: response.date),
            type: OperationType.operationByValue(response.type) ?? .buy,
            activated: response.activated
        ))
    }
    
    func presentRedeemStatus(_ response: OperationDetailsModels.Redeem.Response) {
        viewController?.displayRedeemStatus(Models.Redeem.ViewModel(success: response.success))
    }
    
    func presentStatusError() {
        viewController?.displayStatusError()
    }
}
