//
//  AmountSelectionWorker.swift
//  Stucash
//
//  Created by Maksim Karaseu on 19.04.23.
//

import Foundation
import Alamofire

final class AmountSelectionWorker: AmountSelectionWorkerLogic {
    var networkData: AmountSelectionNetworkDataProtocol
    
    init(networkData: AmountSelectionNetworkDataProtocol) {
        self.networkData = networkData
    }
    
    // MARK: AmountSelectionWorkerLogic
    func checkServiceAvailability(completion: ((Result<AmountSelectionNetworkModels.CheckServiceAvailability.Response, AmountSelectionNetworkModels.Failure>) -> Void)?) { }
    
    func transaction(amount: Int64, completion: ((Result<AmountSelectionNetworkModels.Transaction.Response, AmountSelectionNetworkModels.Failure>) -> Void)?) {
        let endpoint = AmountSelectionEndpoint(
            endpoint: .transact(relativeLink: networkData.relativeLink ?? "")
        )
        
        AF.request(endpoint.compositePath, method: .post, parameters: ["amount" : amount]).response { response in
            guard let data = response.data else {
                DispatchQueue.main.async { completion?(.failure(.emptyResponse)) }
                return
            }
            
            do {
                let response: AmountSelectionNetworkModels.Transaction.Response = try JSONDecoder().decode(
                    AmountSelectionNetworkModels.Transaction.Response.self,
                    from: data
                )
                DispatchQueue.main.async { completion?(.success(response)) }
            } catch {
                DispatchQueue.main.async { completion?(.failure(.parseError)) }
            }
        }
    }
}
