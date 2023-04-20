//
//  OperationDetailsNetworkDataProtocol.swift
//  Stucash
//
//  Created by Maksim Karaseu on 19.04.23.
//

protocol OperationDetailsNetworkDataProtocol {
    var accountId: String { get }
    var operationId: String { get }
    var relativeLink: String? { get set }
}
