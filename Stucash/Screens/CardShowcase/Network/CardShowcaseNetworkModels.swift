//
//  CardShowcaseNetworkModels.swift
//  Stucash
//
//  Created by Maksim Karaseu on 16.04.23.
//

import Foundation

enum CardShowcaseNetworkModels {
    enum CheckServiceAvailability { }
    enum Start { }
    enum Card { }
    enum Operation { }
}

extension CardShowcaseNetworkModels.CheckServiceAvailability {
    struct Request: Encodable {
        let id: String
    }
    
    struct Response: Decodable {
        let description: String
        let id: String
        let methodName: String
        let requestType: String
    }
}

extension CardShowcaseNetworkModels.Start {
    struct Request: Encodable { }
    
    struct Response: Decodable {
        let content: Content
        let actions: [String : CardShowcaseNetworkModels.Action]
    }
    
    struct Content: Decodable {
        let accountId: String
        let userName: String
        let userSurname: String
        let balance: Int64
        let historyItems: [HistoryItem]
        
        struct HistoryItem: Codable {
            let operationId: String
            let title: String
            let description: String
            let price: Int64
            let date: Date
            let transactionType: String
            var activated: Bool?
        }
    }
}

extension CardShowcaseNetworkModels.Card {
    struct Request: Encodable { }
    
    struct Response: Decodable { }
}

extension CardShowcaseNetworkModels {
    struct Action: Codable {
        static let operationActionId = "operation-details"
        static let cardActionId = "card-details"
        
        let title: String
        let relativeLink: String?
        let httpMethod: String?
    }
    
    struct ServerErrorModel: Decodable {
        // Статус ошибки
        let status: String
        // Время возникновения ошибки
        let timestamp: String
        // Сообщение об ошибке
        let message: String
        // Подробное сообщение об ошибке
        let debugMessage: String?
    }

    struct ErrorModel: Decodable {
        // Статус ошибки
        let status: Int
        // Время возникновения ошибки
        let timestamp: Int?
        // Сообщение об ошибке
        let message: String
        // Ошибка
        let error: String?
        // Подробное сообщение об ошибке
        let debugMessage: String?
        // Подробное сообщение о внутренней ошибке
        let internalText: String?
    }

    enum Failure: Error {
        case emptyResponse
        case notAcceptable(model: ServerErrorModel?)
        case undefinedStatus(model: ErrorModel?)
        case undefinedError
        case parseError
        case imageConvertError
    }
}
