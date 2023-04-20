//
//  EndpointConfig.swift
//  Stucash
//
//  Created by Maksim Karaseu on 16.04.23.
//

final public class EndpointConfig {
    static let apiGateway = ""

    static let shared = EndpointConfig()
    private init() { }

    var jwt: String?

    var bearer: String? {
        guard let jwt = jwt else { return nil }
        return "Bearer \(jwt)"
    }
}
