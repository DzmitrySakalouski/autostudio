//
//  CreateClientViewController.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 5.03.21.
//

import UIKit

class CreateClientViewController: UIViewController {
    var closeModalAction: (() -> ())?

    lazy var closeLabel: UILabel = {
        let label = UILabel()
        label.text = "Закрыть"
        label.textColor = .white
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Создать нового клиента"
        label.font = label.font.withSize(30)
        label.textColor = .white
        return label
    }()
    
    lazy var nameTextField: TextField = {
        let fullNameTF = TextField()
        fullNameTF.placeholder = "Имя"
        return fullNameTF
    }()
    
    lazy var carTextField: UITextField = {
        let carTF = TextField()
        carTF.placeholder = "Машина"
        return carTF
    }()
    
    lazy var phoneTextField: TextField = {
        let phoneTF = TextField()
        phoneTF.placeholder = "Номер Телефона"
        return phoneTF
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Сохранить", for: .normal)
        button.layer.borderWidth = 1
        button.tintColor = .white
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 4
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    func configureView() {
        navigationController?.navigationBar.tintColor = .white
        view.backgroundColor = .gray
        
        view.addSubview(closeLabel)
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleCloseModal))
        closeLabel.addGestureRecognizer(tap)
        closeLabel.anchor(top: view.topAnchor, left: view.leftAnchor, paddingTop: 10, paddingLeft: 10)
        
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.topAnchor, paddingTop: 72)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(nameTextField)
        nameTextField.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20, height: 40)
        
        view.addSubview(carTextField)
        carTextField.anchor(top: nameTextField.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20, height: 40)
        
        view.addSubview(phoneTextField)
        phoneTextField.anchor(top: carTextField.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 20, paddingRight: 20, height: 40)
        
        view.addSubview(submitButton)
        submitButton.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 20,
                             paddingBottom: 30, paddingRight: 20)
        submitButton.addTarget(self, action: #selector(handlePressSave), for: .touchUpInside)
        
    }
    
    func setDelegated() {
        nameTextField.delegate = self
        carTextField.delegate = self
        phoneTextField.delegate = self
    }

    @objc func handleCloseModal() {
        guard let closeAction = closeModalAction else {
            return
        }
        
        closeAction()
    }
    
    @objc func handlePressSave() {
        guard let closeAction = closeModalAction else {
            return
        }
        
        closeAction()
    }
}

extension CreateClientViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
        carTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderWidth = 3
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
