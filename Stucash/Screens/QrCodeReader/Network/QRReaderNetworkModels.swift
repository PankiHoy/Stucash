//
//  QRReederNetworkModels.swift
//  Stucash
//
//  Created by Maksim Karaseu on 19.04.23.
//

import Foundation

enum QRReaderNetworkModels {
    enum CheckServiceAvailability { }
    enum Start { }
    enum AmountSelection { }
    enum Redeem { }
}

extension QRReaderNetworkModels.CheckServiceAvailability {
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

extension QRReaderNetworkModels.Start {
    struct Request: Encodable { }
    
    struct Response: Decodable { }
}

extension QRReaderNetworkModels.AmountSelection {
    struct Request: Encodable { }
    
    struct Response: Decodable {
        let recieverId: String
    }
}

extension QRReaderNetworkModels.Redeem {
    struct Request: Encodable { }
    
    struct Response: Decodable { }
}

extension QRReaderNetworkModels {
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
