//
//  AmountSelectionViewControllers.swift
//  Stucash
//
//  Created by Maksim Karaseu on 19.04.23.
//

import Foundation
import UIKit

final class AmountSelectionViewController: UIViewController,
                                           AmountSelectionDisplayLogic {
    typealias Models = AmountSelectionModels
    
    private let interactor: AmountSelectionBusinessLogic
    private let router: AmountSelectionRoutingLogic
    
    let makeButton: (UIColor, String) -> UIButton = { color, title in
        let button = UIButton()
        button.layer.cornerRadius = 25.0
        button.backgroundColor = UIColor.stucashBlack
        button.layer.borderColor = color.cgColor
        button.layer.borderWidth = 0.5
        button.setAttributedTitle(
            NSAttributedString(
                string: title,
                attributes: [
                    NSAttributedString.Key.foregroundColor : color,
                    NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17.0)
                ]
            ),
            for: .normal
        )
        
        return button
    }
    
    private let cardView: SmallCardView
    private let balanceView: UILabel
    private let minusView: UIButton
    private let plusView: UIButton
    private let sumInfo: UILabel
    
    private lazy var textFieldView: UITextField = {
        let textField = UITextField()
        textField.placeholder = "0.00"
        textField.textAlignment = .center
        textField.attributedPlaceholder = NSAttributedString(
            string: "0.00",
            attributes: [
                NSAttributedString.Key.foregroundColor : UIColor.stucashGrey ?? .gray,
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17.0)
            ]
        )
        textField.textColor = UIColor.stucashWhite
        textField.backgroundColor = UIColor.stucashBlack
        textField.tintColor = UIColor.stucashGold
        textField.keyboardType = .numberPad
        
        return textField
    }()
    
    private let doneButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 6.0
        button.backgroundColor = UIColor.stucashGold
        button.setAttributedTitle(
            NSAttributedString(
                string: "TRANSFER",
                attributes: [
                    NSAttributedString.Key.foregroundColor : UIColor.stucashBlack ?? .black,
                    NSAttributedString.Key.font : UIFont.stucashRegular(ofSize: 20.0),
                    NSAttributedString.Key.kern : 2.0
                ]
            ),
            for: .normal
        )
        
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.stucashBlack
        button.setAttributedTitle(
            NSAttributedString(
                string: "Cancel",
                attributes: [
                    NSAttributedString.Key.foregroundColor : UIColor.stucashGold ?? .yellow,
                    NSAttributedString.Key.font : UIFont.stucashRegular(ofSize: 20.0),
                    NSAttributedString.Key.kern : 2.0
                ]
            ),
            for: .normal
        )
        
        return button
    }()
    
    init(interactor: AmountSelectionBusinessLogic, router: AmountSelectionRoutingLogic) {
        self.interactor = interactor
        self.router = router
        
        self.cardView = SmallCardView()
        self.cardView.isUserInteractionEnabled = false
        self.cardView.backgroundColor = UIColor.stucashGold
        self.cardView.layer.cornerRadius = 12.0
        
        self.balanceView = UILabel()
        self.balanceView.isUserInteractionEnabled = false
        self.balanceView.textColor = UIColor.stucashWhite
        self.balanceView.font = UIFont.stucashRegular(ofSize: 55.0)
        
        self.sumInfo = UILabel()
        self.sumInfo.isUserInteractionEnabled = false
        self.sumInfo.textColor = UIColor.stucashGrey
        self.sumInfo.font = UIFont.systemFont(ofSize: 17.0)
        
        self.minusView = makeButton(UIColor.red, "-1,00")
        
        self.plusView = makeButton(UIColor.green, "+1,00")
        
        super.init(nibName: nil, bundle: nil)
        
        self.minusView.addTarget(self, action: #selector(minusPressed), for: .touchUpInside)
        self.plusView.addTarget(self, action: #selector(plusPressed), for: .touchUpInside)
        self.doneButton.addTarget(self, action: #selector(donePressed), for: .touchUpInside)
        self.cancelButton.addTarget(self, action: #selector(cancelPressed), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.requestInitForm(Models.InitialData.Request())
    }
    
    @objc private func dismissKeyboard() {
        textFieldView.resignFirstResponder()
    }
    
    @objc private func backPressed() {
        router.routeBack()
    }
    
    @objc private func minusPressed() {
        self.minusView.tapped { [weak self] in
            guard let self = self else { return }
            var intValue = Int64(self.textFieldView.text ?? "") ?? 0
            intValue -= 1
            self.textFieldView.text = String(intValue > 0 ? intValue : 0)
        }
    }
    
    @objc private func plusPressed() {
        self.plusView.tapped { [weak self] in
            guard let self = self else { return }
            var intValue = Int64(self.textFieldView.text ?? "") ?? 0
            intValue += 1
            self.textFieldView.text = String(intValue)
        }
    }
    
    @objc private func donePressed() {
        guard let text = textFieldView.text,
              !text.isEmpty
        else {
            return
        }
        
        self.doneButton.tapped { [weak self] in
            guard let self = self else { return }
            self.interactor.requestTransaction(Models.Transaction.Request(sum: Int64(text) ?? 0))
        }
    }
    
    @objc private func cancelPressed() {
        self.cancelButton.tapped { [weak self] in
            guard let self = self else { return }
            self.router.routeBack()
        }
    }
    
    // MARK: AmountSelectionDisplayLogic
    func displayInitForm(_ viewModel: AmountSelectionModels.InitialData.ViewModel) { }
    
    func displayTransaction(_ viewModel: AmountSelectionModels.Transaction.ViewModel) {
        router.routeToTransaction()
    }
    
    // MARK: Private
    private func configureUI() {
        configureFields()
    }
    
    private func configureFields() {
        cardView.name = "Maksim Karablev"
        balanceView.text = "1337$"
        sumInfo.text = "Amount of Transfer, $"
    }
    
    override public func viewWillLayoutSubviews() {
        cardView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(cardView)
        
        cardView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30.0).isActive = true
        cardView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 40.0).isActive = true
        cardView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
        cardView.widthAnchor.constraint(equalToConstant: 150.0).isActive = true
        
        balanceView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(balanceView)
        
        balanceView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50.0).isActive = true
        balanceView.leadingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: 20.0).isActive = true
        
        sumInfo.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(sumInfo)
        
        sumInfo.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 30.0).isActive = true
        sumInfo.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        minusView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(minusView)
        
        minusView.topAnchor.constraint(equalTo: sumInfo.bottomAnchor, constant: 16.0).isActive = true
        minusView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0).isActive = true
        minusView.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        minusView.widthAnchor.constraint(equalToConstant: 90.0).isActive = true
        
        plusView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(plusView)
        
        plusView.topAnchor.constraint(equalTo: sumInfo.bottomAnchor, constant: 16.0).isActive = true
        plusView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0).isActive = true
        plusView.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        plusView.widthAnchor.constraint(equalToConstant: 90.0).isActive = true
        
        textFieldView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(textFieldView)
        
        textFieldView.topAnchor.constraint(equalTo: sumInfo.bottomAnchor, constant: 16.0).isActive = true
        textFieldView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        textFieldView.centerYAnchor.constraint(equalTo: plusView.centerYAnchor).isActive = true
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(cancelButton)
        
        cancelButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -22.0).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 55.0).isActive = true
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(doneButton)
        
        doneButton.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -16.0).isActive = true
        doneButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0).isActive = true
        doneButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0).isActive = true
        doneButton.heightAnchor.constraint(equalTo: cancelButton.heightAnchor).isActive = true
    }
}

extension UIButton {
    func tapped(completion: @escaping () -> Void) {
        UIView.animate(
            withDuration: 0.1,
            delay: 0,
            options: .curveLinear,
            animations: { [weak self] in
                self?.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
                self?.alpha = 0.8
            }
        ) { (done) in
            UIView.animate(
                withDuration: 0.1,
                delay: 0,
                options: .curveLinear,
                animations: { [weak self] in
                    self?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
                    self?.alpha = 1.0
                }
            ) { [weak self] (_) in
                self?.isUserInteractionEnabled = true
                completion()
            }
        }
    }
}
