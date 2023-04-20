//
//  SmallCardView.swift
//  Stucash
//
//  Created by Maksim Karaseu on 20.04.23.
//

import UIKit

final class SmallCardView: UIView {
    public var name: String? { didSet { setNeedsDisplay() } }
    
    private let cardImage: UIImageView
    private let nameView: UILabel
    private let iconView: UIImageView
    
    init() {
        self.cardImage = UIImageView()
        self.cardImage.isUserInteractionEnabled = false
        self.cardImage.backgroundColor = UIColor.stucashGold
        self.cardImage.layer.cornerRadius = 12.0
        
        self.nameView = UILabel()
        self.nameView.isUserInteractionEnabled = false
        self.nameView.textColor = UIColor.stucashWhite
        self.nameView.font = UIFont.stucashRegular(ofSize: 17.0)
        
        self.iconView = UIImageView()
        self.iconView.image = UIImage(named: "stucash")?.withRenderingMode(.alwaysTemplate)
        self.iconView.tintColor = UIColor.stucashBlack
        
        super.init(frame: .zero)
        
        self.layer.cornerRadius = 12.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.type = .axial
        gradientLayer.colors = [
            UIColor.stucashDarkGold!.cgColor,
            UIColor.stucashLigthGold!.cgColor,
            UIColor.stucashDarkGold!.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.locations = [0.0, 0.2, 1.0]
        gradientLayer.frame = cardImage.bounds
        
        cardImage.layer.insertSublayer(gradientLayer, at:0)
        
        cardImage.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(cardImage)
                
        cardImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        cardImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        cardImage.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        cardImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        nameView.text = self.name ?? ""
        
        nameView.translatesAutoresizingMaskIntoConstraints = false
        cardImage.addSubview(nameView)
        
        nameView.topAnchor.constraint(equalTo: cardImage.topAnchor, constant: 10.0).isActive = true
        nameView.leadingAnchor.constraint(equalTo: cardImage.leadingAnchor, constant: 10.0).isActive = true
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        cardImage.addSubview(iconView)
        
        iconView.leadingAnchor.constraint(equalTo: cardImage.leadingAnchor, constant: 5.0).isActive = true
        iconView.bottomAnchor.constraint(equalTo: cardImage.bottomAnchor, constant: -5.0).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 45.0).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: 45.0).isActive = true
    }
}
