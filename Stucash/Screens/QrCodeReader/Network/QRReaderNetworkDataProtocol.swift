//
//  QRReederNetworkDataProtocol.swift
//  Stucash
//
//  Created by Maksim Karaseu on 19.04.23.
//

protocol QRReaderNetworkDataProtocol {
    var accountId: String { get }
    var recieverId: String? { get set }
    var relativeLink: String? { get set }
}
