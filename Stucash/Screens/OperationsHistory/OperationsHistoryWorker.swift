//
//  OperationsHistoryWorker.swift
//  Stucash
//
//  Created by Maksim Karaseu on 18.04.23.
//

import Foundation
import Alamofire

final class OperationsHistoryWorker: OperationsHistoryWorkerLogic {
    var networkData: OperationsHistoryNetworkDataProtocol
    
    init(networkData: OperationsHistoryNetworkDataProtocol) {
        self.networkData = networkData
    }
    
    // MARK: OperationsHistoryWorkerLogic
    func checkServiceAvailability(completion: ((Result<OperationsHistoryNetworkModels.CheckServiceAvailability.Response, CardShowcaseNetworkModels.Failure>) -> Void)?) { }
    
    func start(completion: ((Result<OperationsHistoryNetworkModels.Start.Response, CardShowcaseNetworkModels.Failure>) -> Void)?) {
        let endpoint = OperationsHistoryNetworkEndpoint(endpoint: .start(relativeLink: networkData.relativeLink ?? ""))
        
        AF.request(endpoint.compositePath).response { response in
            guard let data = response.data else {
                DispatchQueue.main.async { completion?(.failure(.emptyResponse)) }
                return
            }
            
            do {
                let response: OperationsHistoryNetworkModels.Start.Response = try JSONDecoder().decode(OperationsHistoryNetworkModels.Start.Response.self, from: data)
                DispatchQueue.main.async { completion?(.success(response)) }
            } catch {
                DispatchQueue.main.async { completion?(.failure(.parseError)) }
            }
        }
    }
}
