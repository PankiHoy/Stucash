//
//  QRReederNetworkEndpoint.swift
//  Stucash
//
//  Created by Maksim Karaseu on 19.04.23.
//

struct QRReaderNetworkEndpoint {
    enum Endpoint {
        case checkServiceAvailability
        case redeem(relativeLink: String)
        
        var rawValue: String {
            switch self {
                case .checkServiceAvailability:
                    return "check-service-availability"
                case .redeem(let relativeLink):
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
