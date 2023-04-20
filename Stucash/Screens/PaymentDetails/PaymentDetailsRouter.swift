//
//  PaymentDetailsRouter.swift
//  Stucash
//
//  Created by Maksim Karaseu on 20.04.23.
//

import UIKit

final class PaymentDetailsRouter: PaymentDetailsRoutingLogic {
    weak var viewController: UIViewController?
    
    private let dataStore: PaymentDetailsDataStore
    
    init(dataStore: PaymentDetailsDataStore) {
        self.dataStore = dataStore
    }
    
    // MARK: PaymentDetailsRoutingLogic
    func routeToProceed() {
        viewController?.navigationController?.dismiss(animated: true)
    }
    
    func routeBack() {
        viewController?.navigationController?.popToRootViewController(animated: true)
    }
}
