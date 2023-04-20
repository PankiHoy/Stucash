//
//  PaymentsListWorker.swift
//  Stucash
//
//  Created by Maksim Karaseu on 18.04.23.
//

import Alamofire
import Foundation

final class PaymentsListWorker: PaymentsListWorkerLogic {
    var networkData: PaymentsListNetworkDataProtocol
    
    init(networkData: PaymentsListNetworkDataProtocol) {
        self.networkData = networkData
    }
    
    // MARK: PaymentsListWorkerLogic
    func checkServiceAvailability(completion: ((Result<PaymentsListNetworkModels.CheckServiceAvailability.Response, PaymentsListNetworkModels.Failure>) -> Void)?) { }
    
    func start(completion: ((Result<PaymentsListNetworkModels.Start.Response, PaymentsListNetworkModels.Failure>) -> Void)?) {
        let endpoint = PaymentsListNetworkEndpoint(
            endpoint: .start(relativeLink: networkData.relativeLink ?? "")
        )
        
        AF.request(endpoint.compositePath).response { response in
            guard let data = response.data else {
                DispatchQueue.main.async { completion?(.failure(.emptyResponse)) }
                return
            }
            
            do {
                let response: PaymentsListNetworkModels.Start.Response = try JSONDecoder().decode(PaymentsListNetworkModels.Start.Response.self, from: data)
                DispatchQueue.main.async { completion?(.success(response)) }
            } catch {
                DispatchQueue.main.async { completion?(.failure(.parseError)) }
            }
        }
    }
}
