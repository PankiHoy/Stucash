//
//  PaymentsListRouter.swift
//  Stucash
//
//  Created by Maksim Karaseu on 18.04.23.
//

import UIKit

final class PaymentsListRouter: PaymetsListRoutingLogic {
    weak var viewController: UIViewController?
    
    private let dataStore: PaymentsListDataStore & PaymentsListPaymentsHolder
    
    init(dataStore: PaymentsListDataStore & PaymentsListPaymentsHolder) {
        self.dataStore = dataStore
    }
    
    func routeToPaymentDetailsScene(paymentId: String) {
        guard let payment = dataStore.payments.first(where: { $0.paymentId == paymentId }),
              let networkData = dataStore.networkData
        else {
            return
        }
        
        let controller = PaymentDetailsAssembly.build(
            networkData: PaymentDetailsNetworkData(
                accountId: networkData.accountId,
                paymentId: paymentId,
                relativeLink: networkData.relativeLink
            ),
            payment: PaymentDetailsModels.PaymentItem(
                paymentId: payment.paymentId,
                title: payment.title,
                subtitle: payment.description,
                price: payment.price
            )
        )
        
        viewController?.present(controller, animated: true)
    }
    
    func routeToStatusErrorScene() { }
}
