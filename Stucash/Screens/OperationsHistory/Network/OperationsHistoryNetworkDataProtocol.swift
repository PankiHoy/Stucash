//
//  OperationsHistoryNetworkDataProtocol.swift
//  Stucash
//
//  Created by Maksim Karaseu on 18.04.23.
//

protocol OperationsHistoryNetworkDataProtocol {
    var accountId: String { get }
    var relativeLink: String? { get set }
}
