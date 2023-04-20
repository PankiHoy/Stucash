//
//  CardShowcaseInteractor.swift
//  Stucash
//
//  Created by Maksim Karaseu on 16.04.23.
//

import Foundation
import UIKit

final class CardShowcaseInteractor: CardShowcaseBusinessLogic,
                                    CardShowcaseDataStore,
                                    CardShowcaseOperationHolder {
    typealias Models = CardShowcaseModels
    typealias NetworkModels = CardShowcaseNetworkModels
    
    private enum Strings {
        case title
        case operationsHeader
        
        var baseBath: String? { "CardShowcase" }
    }
    
    private let presenter: CardShowcasePresentationLogic
    private let worker: CardShowcaseWorkerLogic
    
    private(set) var networkData: CardShowcaseNetworkDataProtocol?
    
    public var operations: [Models.OperationItem] = []
    
    init(
        presenter: CardShowcasePresentationLogic,
        worker: CardShowcaseWorkerLogic,
        networkData: CardShowcaseNetworkDataProtocol
    ) {
        self.presenter = presenter
        self.worker = worker
        self.networkData = networkData
    }
    
    private func loadInitForm(_ model: NetworkModels.Start.Response) {
        guard let operationAction = model.actions[NetworkModels.Action.operationActionId] else { return }
        
        self.networkData?.relativeLink = operationAction.relativeLink
        
        self.operations = model.content.historyItems[0..<5].map { item in
            return Models.OperationItem(
                operationId: item.operationId,
                title: item.title,
                description: item.description,
                price: item.price,
                date: item.date,
                type: item.transactionType,
                activated: item.activated ?? false
            )
        }
        
        DispatchQueue.main.async {
            self.presenter.presentInitForm(Models.InitialData.Response(
                userName: model.content.userName,
                userSurname: model.content.userSurname,
                balance: model.content.balance
            ))
        }
    }
    
    private func loadStatusError() {
        self.presenter.presentStatusError()
    }
    
    // MARK: CardShowcaseBusinessLogic
    func requestInitForm(_ request: Models.InitialData.Request) {
        self.worker.start { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                case .success(let model):
                    self.loadInitForm(model)
                case .failure:
//                    self.loadStatusError()
                    self.loadInitForm(NetworkModels.Start.Response(
                        content: CardShowcaseNetworkModels.Start.Content(
                            accountId: "",
                            userName: "Maksim",
                            userSurname: "Karablev",
                            balance: 1488,
                            historyItems: [
                                CardShowcaseNetworkModels.Start.Content.HistoryItem(
                                    operationId: "1",
                                    title: "Transfer To Account",
                                    description: "Transfered 16 stucash to 'DMITRIY'",
                                    price: -16,
                                    date: Date(),
                                    transactionType: "transfer"
                                ),
                                CardShowcaseNetworkModels.Start.Content.HistoryItem(
                                    operationId: "2",
                                    title: "F%#k Homework",
                                    description: "Purchased one homework skip",
                                    price: -322,
                                    date: Date(),
                                    transactionType: "buy",
                                    activated: true
                                ),
                                CardShowcaseNetworkModels.Start.Content.HistoryItem(
                                    operationId: "3",
                                    title: "Sleeping Time",
                                    description: "Purchased the right to sleep during lesson",
                                    price: -228,
                                    date: Date(),
                                    transactionType: "buy",
                                    activated: true
                                ),
                                CardShowcaseNetworkModels.Start.Content.HistoryItem(
                                    operationId: "4",
                                    title: "The King Is Dead Long Live The King",
                                    description: "A day OFF from school",
                                    price: -1488,
                                    date: Date(),
                                    transactionType: "buy",
                                    activated: false
                                ),
                                CardShowcaseNetworkModels.Start.Content.HistoryItem(
                                    operationId: "5",
                                    title: "It's Nice To Be Nice",
                                    description: "Checked out for 300 stucash for good behaviour",
                                    price: +300,
                                    date: Date(),
                                    transactionType: "income"
                                ),
                                CardShowcaseNetworkModels.Start.Content.HistoryItem(
                                    operationId: "6",
                                    title: "I Hate Everything About You",
                                    description: "Absence",
                                    price: -666,
                                    date: Date(),
                                    transactionType: "buy",
                                    activated: true
                                ),
                                CardShowcaseNetworkModels.Start.Content.HistoryItem(
                                    operationId: "7",
                                    title: "Money Can't Buy Happiness, Or Can It..",
                                    description: "Purchased dinner at the canteen",
                                    price: -911,
                                    date: Date(),
                                    transactionType: "buy",
                                    activated: true
                                ),
                                CardShowcaseNetworkModels.Start.Content.HistoryItem(
                                    operationId: "8",
                                    title: "Never Wanted To Dance",
                                    description: "A right to skip the prom",
                                    price: -1337,
                                    date: Date(),
                                    transactionType: "buy",
                                    activated: false
                                )
                            ]
                        ),
                        actions: [
                            "operation-details" : NetworkModels.Action(title: "", relativeLink: "", httpMethod: ""),
                            "card-details" : NetworkModels.Action(title: "", relativeLink: "", httpMethod: "")
                        ]
                    ))
            }
        }
    }
    
    func didTapCard(_ request: CardShowcaseModels.CardAction.Request) { }
}
