//
//  CardShowcaseAssembly.swift
//  Stucash
//
//  Created by Maksim Karaseu on 16.04.23.
//

import UIKit

enum CardShowcaseAssembly {
    static func build(networkData: CardShowcaseNetworkDataProtocol) -> UIViewController {
        let presenter = CardShowcasePresenter()
        let worker = CardShowcaseWorker(networkData: networkData)
        let interactor = CardShowcaseInteractor(
            presenter: presenter,
            worker: worker,
            networkData: networkData
        )
        let router = CardShowcaseRouter(dataStore: interactor)
        let viewController = CardShowcaseViewController(
            interactor: interactor,
            router: router
        )
        
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }
}
