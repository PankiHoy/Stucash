//
//  OperationsHistoryModels.swift
//  Stucash
//
//  Created by Maksim Karaseu on 18.04.23.
//

import Foundation

enum OperationsHistoryModels {
    struct StatusModel {
        let items: [OperationHistoryItem]
        
        struct OperationHistoryItem {
            let operationId: String
            let title: String
            let description: String
            let price: String
            let date: String
            let type: OperationType
            let activated: Bool
        }
    }
    
    enum InitialData {
        struct Request { }
        
        struct Response { }
        
        struct ViewModel { }
    }
    
    enum OperationAction {
        struct Request { }
        
        struct Response { }
    }
    
    struct OperationItem {
        let operationId: String
        let title: String
        let description: String
        let price: Int64
        let date: Date
        let type: String
        let activated: Bool
    }
}
