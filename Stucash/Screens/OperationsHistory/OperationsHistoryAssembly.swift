//
//  OperationsHistoryAssembly.swift
//  Stucash
//
//  Created by Maksim Karaseu on 18.04.23.
//

import UIKit

enum OperationsHistoryAssembly {
    static func build(networkData: OperationsHistoryNetworkDataProtocol) -> UIViewController {
        let presenter = OperationsHistoryPresenter()
        let worker = OperationsHistoryWorker(networkData: networkData)
        let interactor = OperationsHistoryInteractor(
            presenter: presenter,
            worker: worker,
            networkData: networkData
        )
        let router = OperationsHistoryRouter(dataStore: interactor)
        let viewController = OperationsHistoryViewController(
            interactor: interactor,
            router: router
        )
        
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }
}
