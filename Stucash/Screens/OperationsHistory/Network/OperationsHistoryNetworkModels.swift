//
//  OperationsHistoryNetworkModels.swift
//  Stucash
//
//  Created by Maksim Karaseu on 18.04.23.
//

import Foundation

enum OperationsHistoryNetworkModels {
    enum CheckServiceAvailability { }
    enum Start { }
    enum Operation { }
}

extension OperationsHistoryNetworkModels.CheckServiceAvailability {
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

extension OperationsHistoryNetworkModels.Start {
    struct Request: Encodable { }
    
    struct Response: Decodable {
        let content: Content
        let actions: [String : OperationsHistoryNetworkModels.Action]
    }
    
    struct Content: Decodable {
        let accountId: String
        let operations: [Operation]
        
        struct Operation: Decodable {
            let operationId: String
            let title: String
            let description: String
            let price: Int64
            let date: Date
            let type: String
            var activated: Bool?
        }
    }
}

extension OperationsHistoryNetworkModels.Operation {
    struct Request: Encodable {
        let accountId: String
        let operationId: String
    }
    
    struct Response: Decodable { }
}

extension OperationsHistoryNetworkModels {
    struct Action: Codable {
        static let operationActionId = "operation-details"
        
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
