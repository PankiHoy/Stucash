//
//  UIFont + Extension.swift
//  Stucash
//
//  Created by Maksim Karaseu on 16.04.23.
//

import UIKit

extension UIFont {
    static func stucashRegular(ofSize size: CGFloat) -> UIFont {
        UIFont(name: "BebasNeue-Regular", size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }
}
