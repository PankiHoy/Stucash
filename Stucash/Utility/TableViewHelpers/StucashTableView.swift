//
//  OperationsTableView.swift
//  Stucash
//
//  Created by Maksim Karaseu on 17.04.23.
//

import Foundation
import UIKit

final class StucashTableView: UITableView {
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return self.contentSize
    }

    override var contentSize: CGSize {
        didSet{
            self.invalidateIntrinsicContentSize()
        }
    }

    override func reloadData() {
        super.reloadData()
        self.invalidateIntrinsicContentSize()
    }
}
