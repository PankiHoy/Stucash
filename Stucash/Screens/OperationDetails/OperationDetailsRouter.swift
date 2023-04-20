//
//  OperationDetailsRouter.swift
//  Stucash
//
//  Created by Maksim Karaseu on 19.04.23.
//

import UIKit

final class OperationDetailsRouter: OperationDetailsRoutingLogic {
    weak var viewController: UIViewController?
    
    private let dataStore: (OperationDetailsDataStore & OperationDetailsOperationHolder)
    
    init(dataStore: (OperationDetailsDataStore & OperationDetailsOperationHolder)) {
        self.dataStore = dataStore
    }
    
    func routeBack() {
        viewController?.dismiss(animated: true)
    }
}
