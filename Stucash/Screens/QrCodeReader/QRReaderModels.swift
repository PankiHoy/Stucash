//
//  QRReederModels.swift
//  Stucash
//
//  Created by Maksim Karaseu on 19.04.23.
//

import Foundation

enum QRReaderModels {
    enum InitialData { }
    enum AmountSelection { }
    enum Redeem { }
    enum QRAction { }
}

extension QRReaderModels.InitialData {
    struct Request { }
    
    struct Response { }
    
    struct ViewModel { }
}

extension QRReaderModels.AmountSelection {
    struct Request {
        let recieverId: String
    }
    
    struct Response { }
    
    struct ViewModel { }
}

extension QRReaderModels.Redeem {
    struct Request {
        let relativeLink: String
    }
    
    struct Response { }
    
    struct ViewModel { }
}

extension QRReaderModels.QRAction {
    struct Request {
        let string: String
    }
    
    struct Response { }
    
    struct ViewModel { }
}
