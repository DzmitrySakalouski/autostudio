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
            let fullName = viewModel.client.fullName
            titleLabel.text = fullName
            phoneLabel.text = viewModel.client.phoneNumber
            let firstCharIndex = fullName.index(fullName.startIndex, offsetBy: 1)
            let firstChar = String(fullName[..<firstCharIndex])
            avatarLabel.text = firstChar
        }
    }
    
    var chevron: UIImageView = {
        let image = UIImage.init(systemName: "chevron.right")
        let chevron = UIImageView(image: image)
        chevron.tintColor = .white
        return chevron
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.init(name: "Gill Sans", size: 18)
        return label
    }()
    
    var phoneLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.init(name: "Gill Sans", size: 16)
        return label
    }()
    
    var outerContainer: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    var container: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    var avatar: UIView = {
        let v = UIView()
        v.backgroundColor = .gray
        v.layer.cornerRadius = 20
        return v
    }()
    
    var avatarLabel: UILabel = {
        var l = UILabel()
        l.textColor = .white
        l.font = UIFont.init(name: "Gill Sans", size: 26)
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        backgroundColor = .white

        addSubview(outerContainer)
        outerContainer.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        outerContainer.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        outerContainer.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0).isActive = true
        
        outerContainer.addSubview(container)
        
        container.anchor(top: outerContainer.topAnchor, left: outerContainer.leftAnchor, bottom: outerContainer.bottomAnchor, right: outerContainer.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 5, paddingRight: 10)
        
        container.addSubview(chevron)
        chevron.anchor(right: container.rightAnchor, paddingRight: 20, width: 10, height: 20)
        chevron.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        
        container.addSubview(avatar)
        avatar.anchor(left: container.leftAnchor, paddingLeft: 10, width: 60, height: 60)
        avatar.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        avatar.addSubview(avatarLabel)
        avatarLabel.translatesAutoresizingMaskIntoConstraints = false
        avatarLabel.centerYAnchor.constraint(equalTo: avatar.centerYAnchor).isActive = true
        avatarLabel.centerXAnchor.constraint(equalTo: avatar.centerXAnchor).isActive = true
        
        container.addSubview(titleLabel)

        titleLabel.anchor(top: avatar.topAnchor, left: avatar.rightAnchor, paddingTop: 10, paddingLeft: 20)

        container.addSubview(phoneLabel)
        phoneLabel.anchor(top: titleLabel.bottomAnchor, left: avatar.rightAnchor, paddingTop: 3, paddingLeft: 20, paddingBottom: 40)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
