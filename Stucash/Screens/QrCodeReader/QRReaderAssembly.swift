//
//  QRReederAssembly.swift
//  Stucash
//
//  Created by Maksim Karaseu on 19.04.23.
//

import UIKit

enum QRReaderSceneAssembly {
    static func build(networkData: QRReaderNetworkDataProtocol) -> UIViewController {
        let presenter = QRReaderPresenter()
        let worker = QRReaderWorker(networkData: networkData)
        let interactor = QRReaderInteractor(
            presenter: presenter,
            worker: worker,
            networkData: networkData
        )
        let router = QRReaderRouter(dataStore: interactor)
        let viewController = QRReaderViewController(
            interactor: interactor,
            router: router
        )
        
        presenter.viewController = viewController
        router.viewController = viewController
        
        return viewController
    }
}
