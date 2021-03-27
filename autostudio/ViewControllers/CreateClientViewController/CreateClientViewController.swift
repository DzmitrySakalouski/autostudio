//
//  CreateClientViewController.swift
//  autostudio
//
//  Created by Dzmitry  Sakalouski  on 5.03.21.
//

import UIKit
import RxSwift

class CreateClientViewController: UIViewController {
    let disposeBag = DisposeBag()
    var viewModel: CreateClientViewModelType!
    
    let mask = Veil(pattern: "+375 (##) ###-##-##")

    lazy var closeLabel: UILabel = {
        let label = UILabel()
        label.text = "Закрыть"
        label.textColor = .black
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Создать нового клиента"
        label.font = label.font.withSize(30)
        label.textColor = .black
        return label
    }()
    
    lazy var nameTextField: TextField = {
        let fullNameTF = TextField()
        fullNameTF.placeholder = "Имя"
        fullNameTF.textColor = .black
        fullNameTF.tintColor = .black
        return fullNameTF
    }()
    
    lazy var carTextField: UITextField = {
        let carTF = TextField()
        carTF.textColor = .black
        carTF.tintColor = .black
        carTF.placeholder = "Машина"
        return carTF
    }()
        
    lazy var phoneTextField: TextField = {
        let phoneTF = TextField()
        phoneTF.textColor = .black
        phoneTF.tintColor = .black
        phoneTF.placeholder = "Номер Телефона"
        phoneTF.addTarget(self, action: #selector(phoneNumberDidChange), for: .editingChanged)
        return phoneTF
    }()
    
    lazy var submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Сохранить", for: .normal)
        button.layer.borderWidth = 1
        button.tintColor = .black
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 4
        return button
    }()
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureSubscriptions()
    }
    
    func configureView() {
        view.backgroundColor = .white
        
        configureSubscriptions()
        
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
        
        view.addSubview(errorLabel)
        errorLabel.anchor(top: submitButton.bottomAnchor)
        errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
    func setDelegated() {
        nameTextField.delegate = self
        carTextField.delegate = self
        phoneTextField.delegate = self
    }

    @objc func handleCloseModal() {
        guard let closeAction = viewModel?.closeModalAction else {
            print("nooooo")
            return
        }
        closeAction()
    }
    
    @objc func handlePressSave() {
        guard let vm = viewModel else {
            print("NO MODEL")
            return
        }
        
        vm.sumbitClient()
    }
    
    @objc func phoneNumberDidChange(_ sender: UITextField) {
        print(sender)
        guard let currentText = sender.text else  {
            return
        }

        sender.text = mask.mask(input: currentText, exhaustive: false)
    }
    
    func configureSubscriptions() {
        guard let vm = viewModel else { return }
        nameTextField.rx.text.orEmpty.bind(to: vm.name).disposed(by: disposeBag)
        carTextField.rx.text.orEmpty.bind(to: vm.car).disposed(by: disposeBag)
        phoneTextField.rx.text.orEmpty.bind(to: vm.phoneNumber).disposed(by: disposeBag)
        
        vm.errorMessage.subscribe(onNext: { [weak self] messageValue in
            if let message = messageValue {
                self?.errorLabel.text = message
            }
        }).disposed(by: disposeBag)
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
