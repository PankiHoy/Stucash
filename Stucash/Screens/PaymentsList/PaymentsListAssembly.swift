//
//  PaymentsListAssembly.swift
//  Stucash
//
//  Created by Maksim Karaseu on 18.04.23.
//

import UIKit

enum PaymentsListAssembly {
    static func build(networkData: PaymentsListNetworkDataProtocol) -> UIViewController {
        let presenter = PaymentsListPresenter()
        let worker = PaymentsListWorker(networkData: networkData)
        let interactor = PaymetsListInteractor(
            presenter: presenter,
            worker: worker,
            networkData: networkData
        )
        let router = PaymentsListRouter(dataStore: interactor)
        let viewController = PaymentsListViewController(
            interactor: interactor,
            router: router
        )
        
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }
}
