//
//  PaymentDetailsNetworkEndpoint.swift
//  Stucash
//
//  Created by Maksim Karaseu on 20.04.23.
//

struct PaymentDetailsNetworkEndpoint {
    enum Endpoint {
        case checkServiceAvailability
        case proceed(relativeLink: String)
        
        var rawValue: String {
            switch self {
                case .checkServiceAvailability:
                    return "check-service-availability"
                case .proceed(let relativeLink):
                    return relativeLink
            }
        }
    }
    
    var compositePath: String {
        "\(bazePath)\(endpoint.rawValue)"
    }
    
    var bazePath: String {
        switch endpoint {
            default:
                return EndpointConfig.apiGateway
        }
    }
    
    var endpoint: Endpoint
}
