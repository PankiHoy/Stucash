//
//  CardShowcaseWorker.swift
//  Stucash
//
//  Created by Maksim Karaseu on 16.04.23.
//

import Foundation
import Alamofire

final class CardShowcaseWorker: CardShowcaseWorkerLogic {
    var networkData: CardShowcaseNetworkDataProtocol
    
    init(networkData: CardShowcaseNetworkDataProtocol) {
        self.networkData = networkData
    }
    
    // MARK: CardShowcaseWorkerLogic
    func checkServiceAvailability(completion: ((Result<CardShowcaseNetworkModels.CheckServiceAvailability.Response, CardShowcaseNetworkModels.Failure>) -> Void)?) { }
    
    func start(completion: ((Result<CardShowcaseNetworkModels.Start.Response, CardShowcaseNetworkModels.Failure>) -> Void)?) {
        let endpoint = CardShowcaseNetworkEndpoint(endpoint: .start(relativeLink: networkData.relativeLink ?? ""))
        
        AF.request(endpoint.compositePath).response { response in
            guard let data = response.data else {
                DispatchQueue.main.async { completion?(.failure(.emptyResponse)) }
                return
            }
                                                       
            do {
                let response: CardShowcaseNetworkModels.Start.Response = try JSONDecoder().decode(
                    CardShowcaseNetworkModels.Start.Response.self,
                    from: data
                )
                DispatchQueue.main.async { completion?(.success(response)) }
            } catch {
                DispatchQueue.main.async { completion?(.failure(.parseError)) }
            }
        }
    }
}
