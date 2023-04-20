//
//  OperationDetailsNetworkModels.swift
//  Stucash
//
//  Created by Maksim Karaseu on 19.04.23.
//

import Foundation

enum OperationDetailsNetworkModels {
    enum CheckServiceAvailability { }
    enum Start { }
    enum Redeem { }
}

extension OperationDetailsNetworkModels.CheckServiceAvailability {
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

extension OperationDetailsNetworkModels.Start {
    struct Request: Encodable { }
    
    struct Response: Decodable { }
}

extension OperationDetailsNetworkModels.Redeem {
    struct Request: Encodable {
        let accountId: String
        let operationId: String
        let timestamp: Date
    }
    
    struct Response: Decodable {
        let operationId: String
        let activated: Bool
    }
}

extension OperationDetailsNetworkModels {
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
