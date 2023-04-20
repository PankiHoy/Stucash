//
//  QRReederRouter.swift
//  Stucash
//
//  Created by Maksim Karaseu on 19.04.23.
//

import UIKit

final class QRReaderRouter: QRReaderRoutingLogic {
    weak var viewController: UIViewController?
    
    private let dataStore: QRReaderDataStore
    
    init(dataStore: QRReaderDataStore) {
        self.dataStore = dataStore
    }
    
    // MARK: QRReaderRoutingLogic
    func routeToAmountSelection() {
        guard let networkData = dataStore.networkData,
              let recieverId = networkData.recieverId
        else {
            routeBack()
            return
        }
        let controller = AmountSelectionAssembly.build(networkData: AmountSelectionNetworkData(
            accountId: networkData.accountId,
            recieverId: recieverId,
            relativeLink: networkData.relativeLink
        ))
        viewController?.navigationController?.pushViewController(controller, animated: true)
    }
    
    func routeBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
