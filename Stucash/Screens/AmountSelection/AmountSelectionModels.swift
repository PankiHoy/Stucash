//
//  AmountSelectionModels.swift
//  Stucash
//
//  Created by Maksim Karaseu on 19.04.23.
//

enum AmountSelectionModels {
    enum InitialData { }
    enum Transaction { }
}

extension AmountSelectionModels.InitialData {
    struct Request { }
    
    struct Response { }
    
    struct ViewModel { }
}

extension AmountSelectionModels.Transaction {
    struct Request {
        let sum: Int64
    }
    
    struct Response { }
    
    struct ViewModel { }
}
