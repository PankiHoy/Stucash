//
//  PaymentsListModels.swift
//  Stucash
//
//  Created by Maksim Karaseu on 18.04.23.
//

import Foundation

enum PaymentsListModels {
    struct StatusModel {
        let items: [PaymentsListItem]
        
        struct PaymentsListItem {
            let paymentId: String
            let title: String
            let description: String
            let price: String
        }
    }
    
    enum InitialData {
        struct Request { }
        
        struct Response { }
        
        struct ViewModel { }
    }
    
    enum PaymentAction {
        struct Request { }
        
        struct Response { }
    }
    
    struct PaymentItem {
        let paymentId: String
        let title: String
        let description: String
        let price: Int64
    }
}
