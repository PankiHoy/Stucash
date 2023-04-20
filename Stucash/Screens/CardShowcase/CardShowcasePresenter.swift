//
//  CardShowcasePresenter.swift
//  Stucash
//
//  Created by Maksim Karaseu on 16.04.23.
//

import UIKit

final class CardShowcasePresenter: CardShowcasePresentationLogic {
    typealias Models = CardShowcaseModels
    
    weak var viewController: CardShowcaseDisplayLogic?
    
    // MARK: CardShowcasePresentationLogic
    func presentInitForm(_ response: Models.InitialData.Response) {
        viewController?.displayInitForm(Models.InitialData.ViewModel(
            userName: response.userName,
            userSurname: response.userSurname,
            balance: "\(response.balance)$"
        ))
    }
    
    func presentStatusError() {
        viewController?.displayStatusError()
    }
}
