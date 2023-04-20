//
//  PaymentDetailsAssembly.swift
//  Stucash
//
//  Created by Maksim Karaseu on 20.04.23.
//

import UIKit

enum PaymentDetailsAssembly {
    static func build(networkData: PaymentDetailsNetworkDataProtocol, payment: PaymentDetailsModels.PaymentItem) -> UIViewController {
        let presenter = PaymentDetailsPresenter()
        let worker = PaymentDetailsWorker(networkData: networkData)
        let interactor = PaymentDetailsInteractor(
            presenter: presenter,
            worker: worker,
            networkData: networkData
        )
        let router = PaymentDetailsRouter(dataStore: interactor)
        let viewController = PaymentDetailsViewController(
            interactor: interactor,
            router: router
        )
        
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }
}
