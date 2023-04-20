//
//  PaymentsListNetworkModels.swift
//  Stucash
//
//  Created by Maksim Karaseu on 18.04.23.
//

enum PaymentsListNetworkModels {
    enum CheckServiceAvailability { }
    enum Start { }
    enum Payment { }
}

extension PaymentsListNetworkModels.CheckServiceAvailability {
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

extension PaymentsListNetworkModels.Start {
    struct Request: Encodable { }
    
    struct Response: Decodable {
        let content: Content
        let actions: [String: PaymentsListNetworkModels.Action]
    }
    
    struct Content: Decodable {
        let accountId: String
        let availablePayments: [Payment]
        
        struct Payment: Decodable {
            let paymentId: String
            let title: String
            let description: String
            let price: Int64
        }
    }
}

extension PaymentsListNetworkModels.Payment {
    struct Request: Encodable {
        let accountId: String
        let paymentId: String
    }
    
    struct Response: Decodable { }
}

extension PaymentsListNetworkModels {
    struct Action: Codable {
        static let paymentsActionId = "payment-details"
        
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
