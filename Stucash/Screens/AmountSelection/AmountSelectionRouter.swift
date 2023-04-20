//
//  AmountSelectionRouter.swift
//  Stucash
//
//  Created by Maksim Karaseu on 19.04.23.
//

import UIKit

final class AmountSelectionRouter: AmountSelectionRoutingLogic {
    weak var viewController: UIViewController?
    
    private let dataStore: AmountSelectionDataStore
    
    init(dataStore: AmountSelectionDataStore) {
        self.dataStore = dataStore
    }
    
    // MARK: AmountSelectionRoutingLogic
    func routeToTransaction() {
        viewController?.navigationController?.popToRootViewController(animated: true)
    }
    
    func routeBack() {
        viewController?.navigationController?.popToRootViewController(animated: true)
    }
}
