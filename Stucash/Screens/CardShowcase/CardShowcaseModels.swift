//
//  CardShowcaseModels.swift
//  Stucash
//
//  Created by Maksim Karaseu on 16.04.23.
//

import Foundation

enum CardShowcaseModels {
    struct StatusModel {
        let card: Card
        let cardAction: Action
        let historyItemAction: Action
        
        struct Action {
            let relativeLink: String?
        }
        
        struct Card {
            let name: String
            let surname: String
            let balance: Int64
        }
    }
    
    enum InitialData {
        struct Request { }
        
        struct Response {
            let userName: String
            let userSurname: String
            let balance: Int64
        }
        
        struct ViewModel {
            let userName: String
            let userSurname: String
            let balance: String
        }
    }
    
    enum CardAction {
        struct Request { }
        
        struct Response { }
    }
    
    enum HistoryItemAction {
        struct Request { }
        
        struct Response { }
        
        struct ViewModel { }
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
