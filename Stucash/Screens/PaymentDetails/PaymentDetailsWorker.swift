//
//  PaymentDetailsWorker.swift
//  Stucash
//
//  Created by Maksim Karaseu on 20.04.23.
//

import Foundation
import Alamofire

final class PaymentDetailsWorker: PaymentDetailsWorkerLogic {
    var networkData: PaymentDetailsNetworkDataProtocol
    
    init(networkData: PaymentDetailsNetworkDataProtocol) {
        self.networkData = networkData
    }
    
    // MARK: PaymentDetailsWorkerLogic
    func checkServiceAvailability(completion: ((Result<PaymentDetailsNetworkModels.CheckServiceAvailability.Response, PaymentDetailsNetworkModels.Failure>) -> Void)?) { }
    
    func proceed(completion: ((Result<PaymentDetailsNetworkModels.Proceed.Response, PaymentDetailsNetworkModels.Failure>) -> Void)?) {
        let endpoint = PaymentDetailsNetworkEndpoint(
            endpoint: .proceed(relativeLink: networkData.relativeLink ?? "")
        )
        
        AF.request(endpoint.compositePath, method: .post, parameters: ["paymentId" : networkData.paymentId]).response { response in
            guard let data = response.data else {
                DispatchQueue.main.async { completion?(.failure(.emptyResponse)) }
                return
            }
            
            do {
                let response: PaymentDetailsNetworkModels.Proceed.Response = try JSONDecoder().decode(
                    PaymentDetailsNetworkModels.Proceed.Response.self,
                    from: data
                )
                DispatchQueue.main.async { completion?(.success(response)) }
            } catch {
                DispatchQueue.main.async { completion?(.failure(.parseError)) }
            }
        }
    }
}
