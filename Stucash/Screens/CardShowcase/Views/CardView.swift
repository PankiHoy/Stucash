//
//  CardView.swift
//  Stucash
//
//  Created by Maksim Karaseu on 16.04.23.
//

import UIKit

final public class CardView: UIView {
    public var name: String? { didSet { setNeedsLayout() }}
    public var surname: String? { didSet { setNeedsLayout() }}
    public var balance: String? { didSet { setNeedsLayout() }}
    public var icon: String? { didSet { setNeedsLayout() }}
    public var cardImage: String? { didSet { setNeedsLayout() }}
    
    private lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12.0
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        return view
    }()
    
    private let ownerView: UILabel = {
        let view = UILabel(frame: .zero)
        return view
    }()
    
    private let qrView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "qrReciever")
        return view
    }()
    
    private let balanceView: UILabel = {
        let view = UILabel(frame: .zero)
        view.textColor = UIColor.stucashWhite
        view.font = UIFont.systemFont(ofSize: 20.0)
        
        return view
    }()
    
    private let iconView: UIImageView = {
        let view = UIImageView(frame: .zero)
        return view
    }()
    
    public init() {
        super.init(frame: .zero)
        configureViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    private func configureViews() {
        
    }
    
    public override func layoutSubviews() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(containerView)
        
        containerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        imageView.image = UIImage(named: self.cardImage ?? "")
        
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
        gradientLayer.frame = imageView.bounds
                
        imageView.layer.insertSublayer(gradientLayer, at:0)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(imageView)
        
        imageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        
        ownerView.attributedText = NSAttributedString(
            string: "\(self.name ?? "") \(self.surname ?? "")",
            attributes: [
                .font : UIFont.stucashRegular(ofSize: 30.0),
                .foregroundColor : UIColor.stucashWhite ?? .white,
                .kern : 5.0
            ]
        )
        
        ownerView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addSubview(ownerView)
        
        ownerView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 22.0).isActive = true
        ownerView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 22.0).isActive = true
        ownerView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -22.0).isActive = true

        iconView.image = UIImage(named: self.icon ?? "")
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addSubview(iconView)
        
        iconView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -16).isActive = true
        iconView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 16).isActive = true
        
        balanceView.attributedText = NSAttributedString(
            string: self.balance ?? "",
            attributes: [
                .font : UIFont.stucashRegular(ofSize: 30.0),
                .foregroundColor : UIColor.stucashWhite ?? .white,
                .kern : 3.0
            ]
        )
        
        balanceView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addSubview(balanceView)
        
        balanceView.topAnchor.constraint(equalTo: ownerView.bottomAnchor, constant: 16.0).isActive = true
        balanceView.leadingAnchor.constraint(equalTo: ownerView.leadingAnchor).isActive = true
        
        qrView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(qrView)
        
        qrView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0).isActive = true
        qrView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16.0).isActive = true
        qrView.heightAnchor.constraint(equalToConstant: 115.0).isActive = true
        qrView.widthAnchor.constraint(equalToConstant: 115.0).isActive = true
    }
}
