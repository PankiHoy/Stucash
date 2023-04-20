//
//  PaymentDetailsNetworkDataProtocol.swift
//  Stucash
//
//  Created by Maksim Karaseu on 20.04.23.
//

protocol PaymentDetailsNetworkDataProtocol {
    var accountId: String { get }
    var paymentId: String { get }
    var relativeLink: String? { get set }
}
