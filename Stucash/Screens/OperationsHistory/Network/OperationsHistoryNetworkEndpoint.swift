//
//  OperationsHistoryNetworkEndpoint.swift
//  Stucash
//
//  Created by Maksim Karaseu on 18.04.23.
//

struct OperationsHistoryNetworkEndpoint {
    enum Endpoint {
        case checkServiceAvailability
        case start(relativeLink: String)
        case operation(relativeLink: String)
        
        var rawValue: String {
            switch self {
                case .checkServiceAvailability:
                    return "check-service-availability"
                case .start(let relativeLink):
                    return relativeLink
                case .operation(let relativeLink):
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
