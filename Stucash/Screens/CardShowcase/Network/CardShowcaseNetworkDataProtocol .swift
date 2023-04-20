//
//  CardShowcaseNetworkDataProtocol .swift
//  Stucash
//
//  Created by Maksim Karaseu on 16.04.23.
//

protocol CardShowcaseNetworkDataProtocol {
    var accountId: String { get }
    var productType: String { get }
    var relativeLink: String? { get set }
}
