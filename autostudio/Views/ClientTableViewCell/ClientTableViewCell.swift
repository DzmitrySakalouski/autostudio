//
//  ClientTableViewCell.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 20.02.21.
//

import UIKit

class ClientTableViewCell: UITableViewCell {
    var viewModel: ClientCellViewModelType?  {
        didSet {
            guard let viewModel = viewModel else { return }
            titleLabel.text = viewModel.client.fullName
        }
    }
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(16)
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: leftAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
