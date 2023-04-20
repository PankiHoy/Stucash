//
//  AmountSelectionAssembly.swift
//  Stucash
//
//  Created by Maksim Karaseu on 19.04.23.
//

import UIKit

enum AmountSelectionAssembly {
    static func build(networkData: AmountSelectionNetworkDataProtocol) -> UIViewController {
        let presenter = AmountSelectionPresenter()
        let worker = AmountSelectionWorker(networkData: networkData)
        let interactor = AmountSelectionInteractor(
            presenter: presenter,
            worker: worker,
            networkData: networkData
        )
        let router = AmountSelectionRouter(dataStore: interactor)
        let viewController = AmountSelectionViewController(
            interactor: interactor,
            router: router
        )
        
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }
}
