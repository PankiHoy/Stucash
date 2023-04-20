//
//  OperationCell.swift
//  Stucash
//
//  Created by Maksim Karaseu on 17.04.23.
//

import Foundation
import UIKit

enum OperationType: Decodable {
    case transfer
    case buy
    case income
    
    var image: UIImage? {
        switch self {
        case .transfer:
            return UIImage(systemName: "giftcard.fill")
        case .buy:
            return UIImage(systemName: "creditcard")
        case .income:
            return UIImage(systemName: "dollarsign.circle")
        }
    }
    
    static func operationByValue(_ rawValue: String) -> OperationType? {
        switch rawValue {
            case "transfer":
                return .transfer
            case "buy":
                return .buy
            case "income":
                return .income
            default:
                return nil
        }
    }
}

enum Constants {
    static let topInset: CGFloat = 12.5
    static let bottomInset: CGFloat = 12.5
    static let leftInset: CGFloat = 12.5
    static let rightInset: CGFloat = 12.5
    
    static let iconHeight: CGFloat = 30.0
    static let iconWidth: CGFloat = 30.0
}

final class OperationCell: UITableViewCell {
    static let identifier: String = "CardShowcaseOperationTableViewCell"
    
    public var title: String?
    public var subtitle: String?
    public var balance: String?
    public var date: String?
    public var type: OperationType?
    public var activated: Bool = false
    
    private let titleView: UILabel
    private let subtitleView: UILabel
    private let iconView: UIImageView
    private let balanceView: UILabel
    private let dateView: UILabel
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.titleView = UILabel()
        self.titleView.isUserInteractionEnabled = false
        self.titleView.textColor = UIColor.stucashWhite
        self.titleView.font = UIFont.systemFont(ofSize: 17.0)
        
        self.subtitleView = UILabel()
        self.subtitleView.isUserInteractionEnabled = false
        self.subtitleView.textColor = UIColor.stucashGrey
        self.subtitleView.font = UIFont.systemFont(ofSize: 15.0)
        
        self.iconView = UIImageView()
        self.iconView.tintColor = UIColor.stucashGold
        
        self.balanceView = UILabel()
        self.balanceView.isUserInteractionEnabled = false
        self.balanceView.textColor = UIColor.stucashGold
        self.balanceView.font = UIFont.stucashRegular(ofSize: 17.0)
        
        self.dateView = UILabel()
        self.dateView.isUserInteractionEnabled = false
        self.dateView.textColor = UIColor.stucashGrey
        self.dateView.font = UIFont.systemFont(ofSize: 15.0)
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.isUserInteractionEnabled = !activated
        self.backgroundColor = activated ? UIColor.stucashLightBlack : UIColor.stucashBlack
        
        titleView.text = self.title
        subtitleView.text = self.subtitle
        balanceView.text = self.balance
        dateView.text = self.date
        iconView.image = self.type?.image?.withRenderingMode(.alwaysTemplate)
        
        iconView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(iconView)
        
        iconView.heightAnchor.constraint(equalToConstant: Constants.iconHeight).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: Constants.iconWidth).isActive = true
        iconView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.topInset).isActive = true
        iconView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.leftInset).isActive = true

        balanceView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(balanceView)

        balanceView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.topInset).isActive = true
        balanceView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.rightInset).isActive = true
        balanceView.widthAnchor.constraint(equalToConstant: balanceView.intrinsicContentSize.width).isActive = true

        dateView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(dateView)

        dateView.topAnchor.constraint(equalTo: balanceView.bottomAnchor, constant: 3.0).isActive = true
        dateView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.rightInset).isActive = true
        dateView.widthAnchor.constraint(equalToConstant: dateView.intrinsicContentSize.width).isActive = true
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleView)

        titleView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.topInset).isActive = true
        titleView.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: Constants.leftInset).isActive = true
        titleView.trailingAnchor.constraint(equalTo: dateView.leadingAnchor, constant: -Constants.rightInset).isActive = true

        subtitleView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(subtitleView)

        subtitleView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 3.0).isActive = true
        subtitleView.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: Constants.leftInset).isActive = true
        subtitleView.trailingAnchor.constraint(equalTo: dateView.leadingAnchor, constant: -Constants.rightInset).isActive = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) { }
}
