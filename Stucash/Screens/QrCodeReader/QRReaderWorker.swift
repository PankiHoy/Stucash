//
//  QRReederWorker.swift
//  Stucash
//
//  Created by Maksim Karaseu on 19.04.23.
//

import Foundation
import Alamofire

final class QRReaderWorker: QRReaderWorkerLogic {
    var networkData: QRReaderNetworkDataProtocol
    
    init(networkData: QRReaderNetworkDataProtocol) {
        self.networkData = networkData
    }
    
    func checkServiceAvailability(completion: ((Result<QRReaderNetworkModels.CheckServiceAvailability.Response, QRReaderNetworkModels.Failure>) -> Void)?) { }
    
    func redeem(operationId: String, completion: ((Result<QRReaderNetworkModels.Redeem.Response, QRReaderNetworkModels.Failure>) -> Void)?) {
        let endpoint = QRReaderNetworkEndpoint(
            endpoint: .redeem(relativeLink: networkData.relativeLink ?? "")
        )
        
        AF.request(endpoint.compositePath, method: .post, parameters: ["operationId" : operationId]).response { response in
            guard let data = response.data else {
                DispatchQueue.main.async { completion?(.failure(.emptyResponse)) }
                return
            }
            
            do {
                let response: QRReaderNetworkModels.Redeem.Response = try JSONDecoder().decode(
                    QRReaderNetworkModels.Redeem.Response.self,
                    from: data
                )
                DispatchQueue.main.async { completion?(.success(response)) }
            } catch {
                DispatchQueue.main.async { completion?(.failure(.parseError)) }
            }
        }
    }
}
