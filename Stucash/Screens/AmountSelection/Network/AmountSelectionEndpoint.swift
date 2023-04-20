//
//  AmountSelectionEndpoint.swift
//  Stucash
//
//  Created by Maksim Karaseu on 19.04.23.
//

struct AmountSelectionEndpoint {
    enum Endpoint {
        case checkServiceAvailability
        case transact(relativeLink: String)
        
        var rawValue: String {
            switch self {
                case .checkServiceAvailability:
                    return "check-service-availability"
                case .transact(let relativeLink):
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
