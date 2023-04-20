//
//  AmountSelectionNetworkDataProtocol.swift
//  Stucash
//
//  Created by Maksim Karaseu on 19.04.23.
//

protocol AmountSelectionNetworkDataProtocol {
    var accountId: String { get }
    var recieverId: String { get }
    var relativeLink: String? { get set }
}
