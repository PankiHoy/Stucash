//
//  OperationDetailsAssembly.swift
//  Stucash
//
//  Created by Maksim Karaseu on 19.04.23.
//

import UIKit

enum OperationDetailsAssembly {
    static func build(networkData: OperationDetailsNetworkDataProtocol, operation: OperationDetailsModels.OperationItem) -> UIViewController {
        let presenter = OperationDetailsPresenter()
        let worker = OperationDetailsWorker(networkData: networkData)
        let interactor = OperationDetailsInteractor(
            presenter: presenter,
            worker: worker,
            networkData: networkData,
            operation: operation
        )
        let router = OperationDetailsRouter(dataStore: interactor)
        let viewController = OperationDetailsViewController(
            interactor: interactor,
            router: router
        )
        
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }
}
