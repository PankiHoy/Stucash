//
//  PaymentsListInteractor.swift
//  Stucash
//
//  Created by Maksim Karaseu on 18.04.23.
//

import Foundation
import UIKit

final class PaymetsListInteractor: PaymentsListBusinessLogic,
                                   PaymentsListDataStore,
                                   PaymentsListPaymentsHolder {
    typealias Models = PaymentsListModels
    typealias NetworkModels = PaymentsListNetworkModels
    
    private let presenter: PaymentsListPresentationLogic
    private let worker: PaymentsListWorkerLogic
    
    private (set) var networkData: PaymentsListNetworkDataProtocol?
    
    private(set) var payments: [PaymentsListModels.PaymentItem] = []
    
    init(
        presenter: PaymentsListPresentationLogic,
        worker: PaymentsListWorkerLogic,
        networkData: PaymentsListNetworkDataProtocol? = nil)
    {
        self.presenter = presenter
        self.worker = worker
        self.networkData = networkData
    }
    
    private func loadInitForm(_ model: NetworkModels.Start.Response) {
        guard let paymentAction = model.actions[NetworkModels.Action.paymentsActionId] else { return }
        
        self.networkData?.relativeLink = paymentAction.relativeLink
        
        self.payments = model.content.availablePayments.map { item in
            return Models.PaymentItem(
                paymentId: item.paymentId,
                title: item.title,
                description: item.description,
                price: item.price
            )
        }
        
        DispatchQueue.main.async {
            self.presenter.presentInitForm(Models.InitialData.Response())
        }
    }
    
    private func loadStatusError() {
        self.presenter.presentStatusError()
    }
    
    // MARK: PaymentsListBusinessLogic
    func requestInitForm(_ request: PaymentsListModels.InitialData.Request) {
        self.worker.start { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                case .success(let model):
                    self.loadInitForm(model)
                case .failure:
                    self.loadStatusError()
                    self.loadInitForm(NetworkModels.Start.Response(
                        content: PaymentsListNetworkModels.Start.Content(
                            accountId: "",
                            availablePayments: [
                                PaymentsListNetworkModels.Start.Content.Payment(
                                    paymentId: "",
                                    title: "F%#k Homework",
                                    description: "Purchase one homework skip",
                                    price: 322
                                ),
                                PaymentsListNetworkModels.Start.Content.Payment(
                                    paymentId: "",
                                    title: "Sleeping Time",
                                    description: "Purchase the right to sleep during lesson",
                                    price: 228
                                ),
                                PaymentsListNetworkModels.Start.Content.Payment(
                                    paymentId: "",
                                    title: "The King Is Dead Long Live The King",
                                    description: "A day OFF from school",
                                    price: 1488
                                ),
                                PaymentsListNetworkModels.Start.Content.Payment(
                                    paymentId: "",
                                    title: "I Hate Everything About You",
                                    description: "1 Absence",
                                    price: 666
                                ),
                                PaymentsListNetworkModels.Start.Content.Payment(
                                    paymentId: "",
                                    title: "Money Can't Buy Happiness, Or Can It..",
                                    description: "Purchase dinner at the canteen",
                                    price: 911
                                ),
                                PaymentsListNetworkModels.Start.Content.Payment(
                                    paymentId: "",
                                    title: "Never Wanted To Dance",
                                    description: "A right to skip the prom",
                                    price: 1337
                                ),
                            ]
                        ),
                        actions: [NetworkModels.Action.paymentsActionId : NetworkModels.Action(
                            title: "",
                            relativeLink: "",
                            httpMethod: ""
                        )]
                    ))
            }
        }
    }
    
    func didTapPayment(_ request: PaymentsListModels.PaymentAction.Request) { }
}
