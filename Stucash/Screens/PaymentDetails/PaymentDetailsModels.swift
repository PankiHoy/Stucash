//
//  PaymentDetailsModels.swift
//  Stucash
//
//  Created by Maksim Karaseu on 20.04.23.
//

enum PaymentDetailsModels {
    enum InitialData { }
    enum Proceed { }
}

extension PaymentDetailsModels.InitialData {
    struct Request { }
    
    struct Response { }
    
    struct ViewModel { }
}

extension PaymentDetailsModels.Proceed {
    struct Request { }
    
    struct Response { }
    
    struct ViewModel { }
}

extension PaymentDetailsModels {
    struct PaymentItem {
        let paymentId: String
        let title: String
        let subtitle: String
        let price: Int64
    }
}
