//
//  TextField.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 11.03.21.
//

import Foundation
import UIKit

class TextField: UITextField {
    private let border = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        borderStyle = .none
        textColor = .white
        let color: UIColor = .white
        self.attributedPlaceholder = NSAttributedString(string: "placeholder", attributes: [NSAttributedString.Key.foregroundColor : color])

        addSubview(border)
        border.backgroundColor = .white
        border.anchor(top: bottomAnchor, left: leftAnchor, right: rightAnchor, height: 1)
        border.isUserInteractionEnabled = false
    }
}
