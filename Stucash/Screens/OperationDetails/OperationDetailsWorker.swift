//
//  OperationDetailsWorker.swift
//  Stucash
//
//  Created by Maksim Karaseu on 19.04.23.
//

import Foundation
import Alamofire

final class OperationDetailsWorker: OperationDetailsWorkerLogic {
    var networkData: OperationDetailsNetworkDataProtocol
    
    init(networkData: OperationDetailsNetworkDataProtocol) {
        self.networkData = networkData
    }
    
    // MARK: OperationDetailsWorkerLogic
    func checkServiceAvailability(completion: ((Result<CardShowcaseNetworkModels.CheckServiceAvailability.Response, CardShowcaseNetworkModels.Failure>) -> Void)?) { }
    
    func redeem(completion: ((Result<OperationDetailsNetworkModels.Redeem.Response, OperationDetailsNetworkModels.Failure>) -> Void)?) {
        let endpoint = OperationDetailsNetworkEndpoint(
            endpoint: .redeem(relativeLink: networkData.relativeLink ?? "")
        )
        
        AF.request(endpoint.compositePath, method: .post).response { response in
            guard let data = response.data else {
                DispatchQueue.main.async { completion?(.failure(.emptyResponse)) }
                return
            }
            
            do {
                let response: OperationDetailsNetworkModels.Redeem.Response = try JSONDecoder().decode(
                    OperationDetailsNetworkModels.Redeem.Response.self,
                    from: data
                )
                DispatchQueue.main.async { completion?(.success(response)) }
            } catch {
                DispatchQueue.main.async { completion?(.failure(.parseError)) }
            }
        }
    }
}
