//
//  AmountSelectionModels.swift
//  Stucash
//
//  Created by Maksim Karaseu on 19.04.23.
//

import Foundation

enum AmountSelectionNetworkModels {
    enum CheckServiceAvailability { }
    enum Start { }
    enum Transaction { }
}

extension AmountSelectionNetworkModels.CheckServiceAvailability {
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

extension AmountSelectionNetworkModels.Start {
    struct Request: Encodable { }
    
    struct Response: Decodable { }
}

extension AmountSelectionNetworkModels.Transaction {
    struct Request: Encodable { }
    
    struct Response: Decodable { }
}

extension AmountSelectionNetworkModels {
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

