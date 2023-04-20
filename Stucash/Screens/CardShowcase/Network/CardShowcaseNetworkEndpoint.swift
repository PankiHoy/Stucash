//
//  CardShowcaseNetworkEndpoint.swift
//  Stucash
//
//  Created by Maksim Karaseu on 16.04.23.
//

struct CardShowcaseNetworkEndpoint {
    enum Endpoint {
        case checkServiceAvailability
        case start(relativeLink: String)
        case card(relativeLink: String)
        
        var rawValue: String {
            switch self {
                case .checkServiceAvailability:
                    return "check-service-availability"
                case .start(let relativeLink):
                    return relativeLink
                case .card(let relativeLink):
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
