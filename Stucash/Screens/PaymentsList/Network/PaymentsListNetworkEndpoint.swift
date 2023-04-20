//
//  PaymentsListNetworkEndpoint.swift
//  Stucash
//
//  Created by Maksim Karaseu on 18.04.23.
//

struct PaymentsListNetworkEndpoint {
    enum Endpoint {
        case checkServiceAvailability
        case start(relativeLink: String)
        case payment(relativeLink: String)
        
        var rawValue: String {
            switch self {
                case .checkServiceAvailability:
                    return "check-service-availability"
                case .start(let link):
                    return link
                case .payment(let link):
                    return link
            }
        }
    }
    
    var compositePath: String {
        "\(basePath)\(endpoint.rawValue)"
    }
    
    var basePath: String {
        switch endpoint {
            default:
                return EndpointConfig.apiGateway
        }
    }
    
    var endpoint: Endpoint
}
