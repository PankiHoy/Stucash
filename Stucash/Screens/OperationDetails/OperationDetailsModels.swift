//
//  OperationDetailsModels.swift
//  Stucash
//
//  Created by Maksim Karaseu on 19.04.23.
//

import Foundation

enum OperationDetailsModels {
    enum InitialData {
        struct Request { }
        
        struct Response {
            let title: String
            let subtitle: String
            let price: Int64
            let date: Date
            let type: String
            let activated: Bool
        }
        
        struct ViewModel {
            let title: String
            let subtitle: String
            let price: String
            let pricePostitive: Bool
            let date: String
            let type: OperationType
            let activated: Bool
        }
    }
    
    enum Redeem {
        struct Request {
            let operationId: String
        }
        
        struct Response {
            let success: Bool
        }
        
        struct ViewModel {
            let success: Bool
        }
    }
    
    struct OperationItem {
        let operationId: String
        let title: String
        let desctiption: String
        let price: Int64
        let date: Date
        let type: String
        let activated: Bool
    }
}
