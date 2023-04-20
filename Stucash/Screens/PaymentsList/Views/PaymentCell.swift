//
//  PaymentCell.swift
//  Stucash
//
//  Created by Maksim Karaseu on 19.04.23.
//

import Foundation
import UIKit

final class PaymentCell: UITableViewCell {
    static let identifier: String = "PaymentsListTableViewCell"
    
    public var title: String?
    public var subtitle: String?
    public var price: String?
    
    private let titleView: UILabel
    private let subtitleView: UILabel
    private let priceView: UILabel
    private let iconView: UIImageView
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.titleView = UILabel()
        self.titleView.isUserInteractionEnabled = false
        self.titleView.textColor = UIColor.stucashWhite
        self.titleView.font = UIFont.systemFont(ofSize: 17.0)
        
        self.subtitleView = UILabel()
        self.subtitleView.isUserInteractionEnabled = false
        self.subtitleView.textColor = UIColor.stucashGrey
        self.subtitleView.font = UIFont.systemFont(ofSize: 15.0)
        
        self.priceView = UILabel()
        self.priceView.isUserInteractionEnabled = false
        self.priceView.textColor = UIColor.stucashGold
        self.priceView.font = UIFont.systemFont(ofSize: 17.0)
        
        self.iconView = UIImageView()
        self.iconView.image = UIImage(systemName: "dollarsign.circle")?.withRenderingMode(.alwaysTemplate)
        self.iconView.tintColor = UIColor.stucashGold
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.isUserInteractionEnabled = true
        self.backgroundColor = UIColor.stucashBlack
        
        titleView.text = self.title
        subtitleView.text = self.subtitle
        priceView.text = self.price
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(iconView)
        
        iconView.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        iconView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.0).isActive = true
        iconView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10.0).isActive = true
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleView)
        
        titleView.topAnchor.constraint(equalTo: self.topAnchor, constant: 12.0).isActive = true
        titleView.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 7.0).isActive = true
        titleView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        subtitleView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subtitleView)
        
        subtitleView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 5.0).isActive = true
        subtitleView.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 7.0).isActive = true
        subtitleView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}

