//
//  TableViewHelper.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 11.03.21.
//

import Foundation
import UIKit

extension UITableViewController {
    func showEmptyMessage(message: String, viewController: UITableViewController) {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        let errorLabel = UILabel(frame: rect)
        errorLabel.text = message
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center
        errorLabel.sizeToFit()
        
        viewController.tableView.backgroundView = errorLabel
        viewController.tableView.separatorStyle = .none
    }
}
